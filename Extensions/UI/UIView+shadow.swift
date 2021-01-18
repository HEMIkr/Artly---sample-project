//
//  UIView+shadow.swift
//  Extensions
//
//  Created by Aleksander Wędrychowski on 16/01/2021.
//

import UIKit

extension UIView {
    var hasShadow: Bool { layer.shadowColor == UIColor.black.cgColor && layer.shadowRadius > 0 }
    
    public func addShadow(to side: ViewSide = .all, withOpacity opaticy: Float = 0.3, radius: CGFloat = 10) {
        var offset: CGSize {
            switch side {
            case .top:
                return CGSize(width: 1.0, height: -2.0)
            case .bottom:
                return CGSize(width: 0.0, height: 2.0)
            case .left:
                return CGSize(width: -2.0, height: 0.0)
            case .right:
                return CGSize(width: 2.0, height: 0.0)
            case .topAndBottom, .leftAndRight, .all:
                return CGSize.zero
            }
        }
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowOpacity = opaticy
    }
    
    public func removeShadow() {
        self.addShadow(to: .all, withOpacity: 0, radius: 0)
    }

    public enum ViewSide {
        case left, right, top, bottom, topAndBottom, leftAndRight, all
    }
}
