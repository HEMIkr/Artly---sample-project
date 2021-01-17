//
//  UserDetailsViewBuilder.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 17/01/2021.
//

import UIKit
import MapKit
import Extensions

final class UserDetailsViewBuilder {
    
    // MARK: - Properties
    
    private enum Constants {
        static var margin: CGFloat = 6
        static var bigMargin: CGFloat = 20
        static var cornerRadius: CGFloat = 3
        static var imageViewSide: CGFloat = 150
        static var buttonsWidth: CGFloat = 100
        static var mapHeight: CGFloat { UIScreen.main.bounds.height * 2/5 }
    }
    
    private unowned let controller: UserDetailsViewController
    private var view: UIView! { return controller.view }

    init(controller: UserDetailsViewController) {
        self.controller = controller
    }
}

// MARK: - Build views
extension UserDetailsViewBuilder {
    
    func buildView() -> UIView {
        let view = UIView()
        view.backgroundColor = .appBackground
        return view
    }
    
    func buildContentStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.bigMargin
        return stackView
    }
    
    func buildProfileImageView() -> UIImageView {
        let imageView = RoundImageView(image: UIImage(named: "avatarPlaceholder"))
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.appTheme.cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    func buildMapView() -> MKMapView {
        let view = MKMapView()
        view.addShadow()
        view.isScrollEnabled = false
        view.isZoomEnabled = false
        view.isPitchEnabled = false
        view.isRotateEnabled = false
        return view
    }
    
    func buildUsernameLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .font(ofSize: 11, weight: .light)
        return label
    }
    
    func buildNameLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .font(ofSize: 25, weight: .medium)
        label.textAlignment = .left
        return label
    }
    
    func buildExpertiseLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .font(ofSize: 11, weight: .light)
        label.textAlignment = .center
        label.text = ""
        return label
    }
    
    func buildDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .font(ofSize: 13, weight: .light)
        label.textAlignment = .justified
        label.text = ""
        return label
    }
    
    func buildPhotosButton() -> UIButton {
        let button = UIButton()
        button.roundCorners()
        button.addShadow()
        button.addTouchAnimation()
        button.isHidden = true
        button.backgroundColor = .appTheme
        button.setTitle(Strings.UserDetails.photos.localized, for: .normal)
        return button
    }
    
    func buildFollowButton() -> UIButton {
        let button = UIButton()
        button.roundCorners()
        button.addShadow()
        button.addTouchAnimation()
        button.backgroundColor = .appTheme
        button.setTitle(Strings.UserDetails.follow.localized, for: .normal)
        return button
    }
    
    // MARK: - Setup AutoLayout methods

    func setupViews() {
        setupHierarchy()
        setupAutoLayout()
    }

    private func setupHierarchy() {
        view.addSubview(controller.contentStackView)
        view.addSubview(controller.mapView)
        view.addSubview(controller.nameLabel)
        view.addSubview(controller.usernameLabel)
        
        view.addSubview(controller.profileImageView)
        view.addSubview(controller.showPhotosButton)
        view.addSubview(controller.followButton)
        
        controller.contentStackView.addArrangedSubview(controller.expertiseLabel)
        controller.contentStackView.addArrangedSubview(controller.descriptionLabel)
    }

    private func setupAutoLayout() {
        [
            controller.mapView, controller.profileImageView,
            controller.showPhotosButton, controller.contentStackView,
            controller.nameLabel, controller.usernameLabel,
            controller.followButton
        ].forEach { $0?.translatesAutoresizingMaskIntoConstraints = false }
        
        var constraints = setupMapViewLayout()
        constraints.append(contentsOf: setupImageViewLayout())
        constraints.append(contentsOf: setupButtonsLayout())
        constraints.append(contentsOf: setupNameLabelsLayout())
        constraints.append(contentsOf: setupStackViewLayout())
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupMapViewLayout() -> [NSLayoutConstraint] {
        return [
            controller.mapView.topAnchor.constraint(equalTo: view.topAnchor),
            controller.mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controller.mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            controller.mapView.heightAnchor.constraint(equalToConstant: Constants.mapHeight)
        ]
    }
    
    private func setupImageViewLayout() -> [NSLayoutConstraint] {
        return [
            controller.profileImageView.centerYAnchor.constraint(equalTo: controller.mapView.bottomAnchor),
            controller.profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            controller.profileImageView.heightAnchor.constraint(equalToConstant: Constants.imageViewSide),
            controller.profileImageView.widthAnchor.constraint(equalTo: controller.profileImageView.heightAnchor)
        ]
    }
    
    private func setupButtonsLayout() -> [NSLayoutConstraint] {
        return [
            controller.showPhotosButton.centerYAnchor.constraint(equalTo: controller.mapView.bottomAnchor),
            controller.showPhotosButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.margin),
            controller.showPhotosButton.widthAnchor.constraint(equalToConstant: Constants.buttonsWidth),
            controller.showPhotosButton.leadingAnchor.constraint(greaterThanOrEqualTo: controller.profileImageView.trailingAnchor, constant: Constants.bigMargin),
            
            controller.followButton.topAnchor.constraint(equalTo: controller.showPhotosButton.bottomAnchor, constant: Constants.bigMargin),
            controller.followButton.trailingAnchor.constraint(equalTo: controller.showPhotosButton.trailingAnchor),
            controller.followButton.widthAnchor.constraint(equalTo: controller.showPhotosButton.widthAnchor)
        ]
    }
    
    private func setupNameLabelsLayout() -> [NSLayoutConstraint] {
        return [
            controller.nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            controller.nameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: Constants.bigMargin),
            controller.nameLabel.topAnchor.constraint(equalTo: controller.profileImageView.bottomAnchor, constant: Constants.bigMargin),

            controller.usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            controller.usernameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: Constants.bigMargin),
            controller.usernameLabel.topAnchor.constraint(equalTo: controller.nameLabel.bottomAnchor, constant: 0)
        ]
    }
    
    private func setupStackViewLayout() -> [NSLayoutConstraint] {
        return [
            controller.contentStackView.topAnchor.constraint(equalTo: controller.usernameLabel.bottomAnchor, constant: Constants.bigMargin),
            controller.contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.bigMargin),
            controller.contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.bigMargin),
            controller.contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
    }
    
}
