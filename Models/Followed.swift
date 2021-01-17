//
//  Followed.swift
//  Models
//
//  Created by Aleksander Wędrychowski on 17/01/2021.
//

import Foundation

public struct Followed: Codable, Equatable {
    public let id: Int
    
    public init(id: Int) {
        self.id = id
    }
}
