//
//  Collection+safe.swift
//  Extensions
//
//  Created by Aleksander Wędrychowski on 14/01/2021.
//

import Foundation

extension Collection {
    public subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
