//
//  UsersViewModel.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 13/01/2021.
//

import UIKit

extension UIView {
    public func addConstraintedSubview(_ subview: UIView, constant: CGFloat = 0) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor, constant: constant),
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constant),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -constant),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -constant)
        ])
    }
}
