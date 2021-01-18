//
//  UserCellViewBuilder.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 17/01/2021.
//

import UIKit
import Extensions

struct UserCellViewBuilder {
    
    // MARK: - Properties
    
    static var cellHeight: CGFloat { Constants.height }
    private enum Constants {
        static var margin: CGFloat = 6
        static var bigMargin: CGFloat = 20
        static var cornerRadius: CGFloat = 6
        static var internalContentViewHeight: CGFloat = 80
        static var height: CGFloat { Constants.internalContentViewHeight + (Constants.margin * 2) }
        static var widthMultiplier: CGFloat = 0.8
        static var titleFontSize: CGFloat = 13
        static var messageFontSize: CGFloat = 11
        static var imageViewSide: CGFloat = 60
        static var followImageSide: CGFloat = 25
    }
    
    private unowned let cell: UserTableViewCell
    
    init(_ cell: UserTableViewCell) {
        self.cell = cell
    }
}

// MARK: - Build views
extension UserCellViewBuilder {
    
    func buildInternalContentView() -> UIView {
        let view = UIView()
        view.roundCorners(radius: Constants.cornerRadius)
        view.addShadow()
        view.backgroundColor = .appBackground
        return view
    }
    
    func buildLabelsStackView() -> UIStackView {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = Constants.margin
        return view
    }
    
    func buildUsernameLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .font(ofSize: 11, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func buildNameLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .font(ofSize: 20, weight: .medium)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func buildFieldOfExpertiseLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .font(ofSize: 13, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func buildProfileImageView() -> UIImageView {
        let imageView = RoundImageView(image: nil)
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.appTheme.cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    func buildFollowedImageView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "followed"))
        imageView.tintColor = .appTheme
        imageView.contentMode = .scaleAspectFill
        imageView.isHidden = true
        return imageView
    }
    
    // MARK: - Setup AutoLayout methods
    
    func setupViews() {
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        cell.addSubview(cell.internalContentView)
        cell.internalContentView.addSubview(cell.profileImageView)
        cell.internalContentView.addSubview(cell.labelsStackView)
        cell.internalContentView.addSubview(cell.followedImageView)
        cell.labelsStackView.addArrangedSubview(cell.nameLabel)
        cell.labelsStackView.addArrangedSubview(cell.usernameLabel)
        cell.labelsStackView.addArrangedSubview(cell.expertiseLabel)
    }
    
    private func setupLayout() {
        cell.internalContentView.translatesAutoresizingMaskIntoConstraints = false
        cell.profileImageView.translatesAutoresizingMaskIntoConstraints = false
        cell.labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        cell.followedImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cell.internalContentView.topAnchor.constraint(equalTo: cell.topAnchor, constant: Constants.margin),
            cell.internalContentView.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            cell.internalContentView.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
            cell.internalContentView.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: Constants.widthMultiplier),
            
            cell.profileImageView.topAnchor.constraint(equalTo: cell.internalContentView.topAnchor, constant: Constants.bigMargin),
            cell.profileImageView.leadingAnchor.constraint(equalTo: cell.internalContentView.leadingAnchor, constant: Constants.bigMargin),
            cell.profileImageView.bottomAnchor.constraint(lessThanOrEqualTo: cell.internalContentView.bottomAnchor, constant: -Constants.bigMargin),
            
            cell.profileImageView.widthAnchor.constraint(equalToConstant: Constants.imageViewSide),
            cell.profileImageView.heightAnchor.constraint(equalTo: cell.profileImageView.widthAnchor),
            
            cell.labelsStackView.topAnchor.constraint(equalTo: cell.internalContentView.topAnchor, constant: Constants.bigMargin),
            cell.labelsStackView.leadingAnchor.constraint(equalTo: cell.profileImageView.trailingAnchor, constant: Constants.bigMargin),
            cell.labelsStackView.trailingAnchor.constraint(equalTo: cell.internalContentView.trailingAnchor, constant: -Constants.bigMargin),
            cell.labelsStackView.bottomAnchor.constraint(equalTo: cell.internalContentView.bottomAnchor, constant: -Constants.bigMargin),
            
            cell.followedImageView.topAnchor.constraint(equalTo: cell.internalContentView.topAnchor, constant: Constants.bigMargin),
            cell.followedImageView.trailingAnchor.constraint(equalTo: cell.internalContentView.trailingAnchor, constant: -Constants.bigMargin),
            cell.followedImageView.widthAnchor.constraint(equalToConstant: Constants.followImageSide),
            cell.followedImageView.topAnchor.constraint(equalTo: cell.followedImageView.topAnchor)
        ])
    }
}
