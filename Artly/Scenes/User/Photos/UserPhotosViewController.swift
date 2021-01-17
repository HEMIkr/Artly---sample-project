//
//  UserPhotosViewController.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 17/01/2021.
//

import UIKit

final class UserPhotosViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private enum Constants {
        static var cellSizeMultiplier: CGFloat { 0.8 }
    }
    let photoUrls: [URL]
    
    // MARK: - Lifecycle
    
    init(_ photoUrls: [URL]) {
        self.photoUrls = photoUrls
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.photoUrls = []
        assertionFailure()
        super.init(coder: coder)
    }
    
    override func loadView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view = collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup methods
    
    private func setup() {
        setupCollectionView()
        setupNavigationBar()
    }
    
    private func setupCollectionView() {
        collectionView.register(UserPhotoCell.self, forCellWithReuseIdentifier: NSStringFromClass(UserPhotoCell.self))
        collectionView.backgroundColor = .appBackground
    }
    
    private func setupNavigationBar() {
        let closeItem = UIBarButtonItem(title: Strings.close.localized, style: .done, target: self, action: #selector(closeTapped))
        navigationItem.leftBarButtonItem = closeItem
    }
    
    // MARK: - Actions
    
    @objc private func closeTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - CollectionView delegates methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoUrls.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(UserPhotoCell.self), for: indexPath)
        if let cell = cell as? UserPhotoCell, let accordingUrl = photoUrls[safe: indexPath.row] {
            cell.configure(using: accordingUrl)
        }
        return cell
    }
    
}

extension UserPhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width * Constants.cellSizeMultiplier, height: collectionView.frame.height * Constants.cellSizeMultiplier)
    }
}
