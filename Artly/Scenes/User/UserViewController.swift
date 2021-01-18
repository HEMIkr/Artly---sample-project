//
//  UserDetailsViewController.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 16/01/2021.
//

import UIKit
import Models
import MapKit

protocol UserDetailsViewBehaviour: ViewBehaviour {
    func displayUserDetails(_ user: User)
    func displayRegion(_ region: MKCoordinateRegion)
}

final class UserDetailsViewController: UIViewController {
    // MARK: - Properties
    
    private var dataProvider: UserDetailsDataProvider!
    private var router: UserDetailsRouter!

    // MARK: Views
    
    private(set) var contentStackView: UIStackView!
    private(set) var profileImageView: UIImageView!
    private(set) var nameLabel: UILabel!
    private(set) var usernameLabel: UILabel!
    private(set) var expertiseLabel: UILabel!
    private(set) var mapView: MKMapView!
    private(set) var showPhotosButton: UIButton!
    private(set) var followButton: UIButton!
    private(set) var descriptionLabel: UILabel!
    
    // MARK: - Lifecycle
    
    required init(_ user: User) {
        super.init(nibName: nil, bundle: nil)
        setupScene(user)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        buildView()
        buildActions()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataProvider?.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setupDesign(.transparent)
    }
    
    // MARK: - Setup
    
    private func setupScene(_ user: User) {
        self.dataProvider = UserDetailsViewModel(viewBehaviour: self, user: user)
        self.router = UserDetailsRouter(controller: self)
    }
    
    // MARK: - View building
    
    private func buildView() {
        let builder = UserDetailsViewBuilder(controller: self)
        view = builder.buildView()
        contentStackView = builder.buildContentStackView()
        profileImageView = builder.buildProfileImageView()
        nameLabel = builder.buildNameLabel()
        usernameLabel = builder.buildUsernameLabel()
        expertiseLabel = builder.buildExpertiseLabel()
        mapView = builder.buildMapView()
        showPhotosButton = builder.buildPhotosButton()
        followButton = builder.buildFollowButton()
        descriptionLabel = builder.buildDescriptionLabel()
        
        builder.setupViews()
    }
    
    private func buildActions() {
        followButton.addTarget(self, action: #selector(followTapped), for: .touchUpInside)
        showPhotosButton.addTarget(self, action: #selector(showPhotosTapped), for: .touchUpInside)
        mapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(mapViewTapped)))
    }
    
    // MARK: - Helpers
    
    private func updateFollowButton() {
        let follow = Strings.UserDetails.follow.localized
        let unfollow = Strings.UserDetails.unfollow.localized
        let followTitle = followButton.title(for: .normal) == follow ? unfollow : follow
        self.followButton.setTitle(followTitle, for: .normal)
    }
    
    // MARK: - Actions
    
    @objc private func mapViewTapped(_ sender: UIGestureRecognizer) {
        router?.navigate(to: .map(mapView.region))
    }
    
    @objc private func followTapped(_ sender: UIButton) {
        guard dataProvider?.toggleFollow() == true else {
            assertionFailure()
            return
        }
        updateFollowButton()
    }
    
    @objc private func showPhotosTapped(_ sender: UIButton) {
        let photos = dataProvider.getUser().imageUrls
        router?.navigate(to: .photos(photos))
    }
}

// MARK: - View Behaviour methods
extension UserDetailsViewController: UserDetailsViewBehaviour {
    func displayRegion(_ region: MKCoordinateRegion) {
        DispatchQueue.main.async {
            self.mapView.setRegion(region, animated: false)
        }
    }
    
    func displayUserDetails(_ user: User) {
        DispatchQueue.main.async {
            self.profileImageView.getImage(from: user.profileImageUrl)
            self.usernameLabel.text = "@" + user.username
            self.nameLabel.text = user.displayName
            if user.fields.isEmpty == false {
                self.expertiseLabel.text = Strings.Users.fieldsOfExpertise.localized + "\n" + user.fields.joined(separator: ", ")
            }
            self.descriptionLabel.text = user.description
            self.showPhotosButton.isHidden = user.imageUrls.isEmpty
            let followTitle = user.isFollowed ?? false ? Strings.UserDetails.unfollow.localized : Strings.UserDetails.follow.localized
            self.followButton.setTitle(followTitle, for: .normal)
        }
    }
    
    func displayError(_ error: Error) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
            alertController.addAction(.init(title: Strings.ok.localized, style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
