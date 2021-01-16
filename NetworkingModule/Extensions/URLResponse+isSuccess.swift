//
//  URLResponse+isSuccess.swift
//  
//
//  Created by Aleksander Wędrychowski on 13/01/2021.
//

import Foundation

extension URLResponse {
    private static let successStatusCodes = (200...299)
    var isSuccess: Bool {
        guard let response = self as? HTTPURLResponse else {
            assertionFailure()
            return false
        }
        return URLResponse.successStatusCodes.contains(response.statusCode)
    }
}
