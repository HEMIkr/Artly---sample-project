//
//  User.swift
//  Models
//
//  Created by Aleksander Wędrychowski on 14/01/2021.
//

import Foundation

public class User: Codable {
    public let id: Int
    public let firstName: String
    public let lastName: String
    public let username: String
    public let displayName: String
    public let city: String?
    public let country: String?
    public let fields: [String]
    public let description: String?
    private let url: String?
    private let images: [String]?
    private let profileImagePath: String
    private(set) public var isFollowed: Bool? = false
    
    public var profileImageUrl: URL? { URL(string: profileImagePath) }
    public var profileUrl: URL? {
        if let url = url {
            return URL(string: url)
        }
        return nil
    }
    public var imageUrls: [URL] { images?.compactMap { URL(string: $0) } ?? []}
    
    public func setFollowed(_ isFollowed: Bool) {
        self.isFollowed = isFollowed
    }
}
