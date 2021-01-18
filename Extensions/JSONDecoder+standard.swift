//
//  JSONDecoder+standard.swift
//  Extensions
//
//  Created by Aleksander Wędrychowski on 14/01/2021.
//

import Foundation

extension JSONDecoder {
    public static var standard: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
