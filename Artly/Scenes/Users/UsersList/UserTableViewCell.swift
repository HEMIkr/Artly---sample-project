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
    
    static var cellHeight: CGFloat { Constants.height }
    private enum Constants {
        static var margin: CGFloat = 6
        static var bigMargin: CGFloat = 20
        static var cornerRadius: CGFloat = 3
        static var internalContentViewHeight: CGFloat = 80
        static var height: CGFloat { Constants.internalContentViewHeight + (Constants.margin * 2) }
        static var widthMultiplier: CGFloat = 0.8
        static var titleFontSize: CGFloat = 13
        static var messageFontSize: CGFloat = 11
        static var imageViewSide: CGFloat = 50
    }
    
    // MARK: Views

    private let internalContentView = UIView()
    private let profileImageView = UIImageView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let showDetailsButton = UIButton()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Setup methods
    
    private func setup() {
        selectionStyle = .none
        backgroundColor = .clear
        addTouchAnimation()
        setupInternalContentView()
        setupProfileImageView()
        setupTitleLabel()
        setupMessageLabel()
    }
    
    private func setupInternalContentView() {
        internalContentView.roundCorners(radius: Constants.cornerRadius)
        internalContentView.addShadow()
        internalContentView.backgroundColor = .white
        internalContentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(internalContentView)
        
        NSLayoutConstraint.activate([
            self.internalContentView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.margin),
            self.internalContentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.internalContentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.internalContentView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: Constants.widthMultiplier)
        ])
    }
    
    private func setupProfileImageView() {
        internalContentView.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.roundCorners()
        NSLayoutConstraint.activate([
            self.profileImageView.topAnchor.constraint(equalTo: self.internalContentView.topAnchor, constant: Constants.bigMargin),
            self.profileImageView.leadingAnchor.constraint(equalTo: self.internalContentView.leadingAnchor, constant: Constants.bigMargin),
            self.profileImageView.widthAnchor.constraint(equalToConstant: Constants.imageViewSide),
            self.profileImageView.heightAnchor.constraint(equalTo: self.profileImageView.widthAnchor)
        ])
    }
    private func setupTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.font = .font(ofSize: 20, weight: .medium)
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        internalContentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.internalContentView.topAnchor, constant: Constants.bigMargin),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: Constants.bigMargin),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.internalContentView.trailingAnchor, constant: -Constants.bigMargin)
        ])
    }

    private func setupMessageLabel() {
        messageLabel.numberOfLines = 0
        messageLabel.font = .font(ofSize: 13, weight: .light)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        internalContentView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            self.messageLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: Constants.margin),
            self.messageLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.messageLabel.trailingAnchor.constraint(equalTo: self.internalContentView.trailingAnchor, constant: -Constants.bigMargin),
            self.messageLabel.bottomAnchor.constraint(equalTo: self.internalContentView.bottomAnchor, constant: -Constants.bigMargin)
        ])
    }
    
    // MARK: - Endpoints

    func configure(using user: User) {
        titleLabel.text = user.firstName + " " + user.lastName
        if user.fields.isEmpty == false {
            messageLabel.text = Strings.Users.fieldsOfExpertise.localized + "\n– " + user.fields.joined(separator: "\n– ")
        }
        profileImageView.getImage(from: user.profileImageUrl)
    }
}
