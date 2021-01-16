//
//  File.swift
//  
//
//  Created by Aleksander Wędrychowski on 13/01/2021.
//

import Foundation
import Models

public enum CreativesToFollow {
    public struct Response: Decodable {
        public let users: [User]
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            self.users = try container.decode([User].self)
        }
    }
}
