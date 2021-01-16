//
//  APIService.swift
//  
//
//  Created by Aleksander Wędrychowski on 13/01/2021.
//

import Foundation
import Extensions

public final class APIService {
    var manager: URLSession {
        return URLSession.shared
    }
    
    public init() { }
    
    func handle<T: Decodable>(_ dataTaskResponse: URLDataTaskResponse, result: @escaping (Result<T, Error>) -> Void) {
        if dataTaskResponse.response?.isSuccess == true, let responseData = dataTaskResponse.data {
            do {
                let responseModel = try T.make(from: responseData)
                result(.success(responseModel))
            } catch {
                result(.failure(NetworkingError.unableToDecodeRequestedType))
            }
        } else {
            let error = dataTaskResponse.error ?? NetworkingError.unknown
            result(.failure(error))
        }
    }
}
