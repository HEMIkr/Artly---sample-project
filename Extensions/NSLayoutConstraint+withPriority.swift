//
//  NSLayoutConstraint+withPriority.swift
//  Extensions
//
//  Created by Aleksander Wędrychowski on 17/01/2021.
//

import UIKit

extension NSLayoutConstraint {
    @discardableResult
    public func withPriority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}
