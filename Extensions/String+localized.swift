//
//  String+localized.swift
//  Extensions
//
//  Created by Aleksander Wędrychowski on 16/01/2021.
//

import Foundation

extension String {
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
