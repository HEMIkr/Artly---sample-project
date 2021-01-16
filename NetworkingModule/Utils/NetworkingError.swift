//
//  NetworkingError.swift
//  
//
//  Created by Aleksander Wędrychowski on 13/01/2021.
//

import Foundation

enum NetworkingError: LocalizedError {
    case unableToDecodeRequestedType
    case unableToPerformRequest
    case unknown
}
