//
//  Decodable+make.swift
//  Extensions
//
//  Created by Aleksander Wędrychowski on 14/01/2021.
//

import Foundation

extension Decodable {
    public static func make(from data: Data) throws -> Self {
        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        print(json)
        return try JSONDecoder.standard.decode(Self.self, from: data)
    }
}
