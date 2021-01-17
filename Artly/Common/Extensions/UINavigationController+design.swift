//
//  UINavigationController+design.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 17/01/2021.
//

import UIKit

extension UINavigationController {
    
    enum Design {
        case standard
        case transparent
    
    }
    
    func setupDesign(_ design: Design) {
        switch design {
        case .standard:
            navigationBar.isTranslucent = false
            navigationBar.tintColor = UIColor.additionalTextColor
            navigationBar.addShadow()
            navigationBar.barTintColor = UIColor.appBackground
        case .transparent:
            navigationBar.tintColor = UIColor.textColor
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.isTranslucent = true
        }
    }
}
