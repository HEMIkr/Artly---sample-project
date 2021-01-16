//
//  URLRequestParameterizable.swift
//  
//
//  Created by Aleksander Wędrychowski on 13/01/2021.
//

import Foundation

public protocol URLRequestParameterizable {
    func querryItems() -> [URLQueryItem]
    func bodyItems() -> [String: Any]
}

public extension URLRequestParameterizable {
    func querryItems() -> [URLQueryItem] { [] }
    func bodyItems() -> [String: Any] { [:] }
}
