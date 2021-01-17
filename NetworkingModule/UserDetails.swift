//
//  UserDetails.swift
//  NetworkingModule
//
//  Created by Aleksander Wędrychowski on 17/01/2021.
//

import Foundation
import Models

public struct UserDetails {
    public struct Request {
        public let id: Int
        
        public init(id: Int) {
            self.id = id
        }
    }
    
    public struct Response: Codable {
        public let user: User
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            self.user = try container.decode(User.self)
        }
    }
}
