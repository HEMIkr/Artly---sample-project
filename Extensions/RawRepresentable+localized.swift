//
//  RawRepresentable+localized.swift
//  Extensions
//
//  Created by Aleksander Wędrychowski on 16/01/2021.
//

import Foundation
import UIKit
public extension RawRepresentable where RawValue == String {
    var localized: String {
        return rawValue.localized
    }
}
