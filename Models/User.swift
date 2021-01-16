//
//  User.swift
//  Models
//
//  Created by Aleksander Wędrychowski on 14/01/2021.
//

import Foundation

public struct User: Codable {
    public let id: Int
    public let firstName: String
    public let lastName: String
    public let username: String
    public let city: String
    public let country: String
    public let fields: [String]
    private let url: String
    private let images: [String]
    private let profileImagePath: String
    
    public var profileImageUrl: URL? { URL(string: profileImagePath) }
    public var profileUrl: URL? { URL(string: url) }
    public var imageUrls: [URL] { images.compactMap { URL(string: $0) }}
}
