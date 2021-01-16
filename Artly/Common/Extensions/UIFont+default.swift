//
//  UIFont+default.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 16/01/2021.
//

import UIKit

extension UIFont {
    static func font(ofSize size: CGFloat, weight: Weight) -> UIFont {
        return .systemFont(ofSize: size, weight: weight)
    }
}
