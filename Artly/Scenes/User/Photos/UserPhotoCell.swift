//
//  UserPhotoCell.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 17/01/2021.
//

import UIKit

final class UserPhotoCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let imageView = UIImageView()
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    // MARK: - Setup methods
    
    private func setup() {
        setupImageView()
        setupActivityIndicator()
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .appTheme
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Endpoints
    
    func configure(using url: URL) {
        activityIndicator.startAnimating()
        imageView.getImage(from: url) { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
}
