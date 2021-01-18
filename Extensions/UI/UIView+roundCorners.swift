//
//  UIView+roundCorners.swift
//  Extensions
//
//  Created by Aleksander Wędrychowski on 16/01/2021.
//

import UIKit

extension UIView {
    public func roundCorners(
        _ corners: CACornerMask = .init(arrayLiteral: .init([.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])),
        radius: CGFloat? = nil) {
        let radius = radius ?? Constants.cornerRadius
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
}
