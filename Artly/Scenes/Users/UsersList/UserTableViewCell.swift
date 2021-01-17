//
//  UserTableViewCell.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 16/01/2021.
//

import Extensions
import UIKit
import Models

final class UserTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static var cellHeight: CGFloat { UserCellViewBuilder.cellHeight }
    private(set) var internalContentView: UIView!
    private(set) var labelsStackView: UIStackView!
    private(set) var profileImageView: UIImageView!
    private(set) var nameLabel: UILabel!
    private(set) var usernameLabel: UILabel!
    private(set) var expertiseLabel: UILabel!
    private(set) var followedImageView: UIImageView!
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        followedImageView.isHidden = true
        [nameLabel, usernameLabel, expertiseLabel].forEach { $0.text = nil }
    }
    
    // MARK: - Setup methods
    
    private func setup() {
        selectionStyle = .none
        backgroundColor = .clear
        
        let builder = UserCellViewBuilder(self)
        internalContentView = builder.buildInternalContentView()
        labelsStackView = builder.buildLabelsStackView()
        profileImageView = builder.buildProfileImageView()
        usernameLabel = builder.buildUsernameLabel()
        nameLabel = builder.buildNameLabel()
        expertiseLabel = builder.buildFieldOfExpertiseLabel()
        followedImageView = builder.buildFollowedImageView()
        
        builder.setupViews()
        addTouchAnimation()
    }
    
    // MARK: - Endpoints

    func configure(using user: User) {
        nameLabel.text = user.displayName
        usernameLabel.text = "@" + user.username
        if user.fields.isEmpty == false {
            expertiseLabel.text = Strings.Users.fieldsOfExpertise.localized + "\n– " + user.fields.joined(separator: "\n– ")
        }
        profileImageView.getImage(from: user.profileImageUrl)
        followedImageView.isHidden = !(user.isFollowed ?? false)
    }
}
