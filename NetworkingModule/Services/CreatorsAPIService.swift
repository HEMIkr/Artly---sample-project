//
//  File 2.swift
//  
//
//  Created by Aleksander Wędrychowski on 13/01/2021.
//

import Foundation

public protocol UsersAPIService: AnyObject {
    func getCretorsToFollow(result: @escaping (Result<CreativesToFollow.Response, Error>) -> Void)
    func getUserDetails(_ requestModel: UserDetails.Request, result: @escaping (Result<UserDetails.Response, Error>) -> Void)
}

extension APIService: UsersAPIService {
    public func getCretorsToFollow(result: @escaping (Result<CreativesToFollow.Response, Error>) -> Void) {
        guard let request = APIRouter.creativesToFollow.asURLRequest else {
            assertionFailure()
            result(.failure(NetworkingError.unableToPerformRequest))
            return
        }
        manager.dataTask(with: request, dataTaskCompletion: { [weak self] response in
            self?.handle(response, result: result)
        })
        .resume()
    }
    
    public func getUserDetails(_ requestModel: UserDetails.Request, result: @escaping (Result<UserDetails.Response, Error>) -> Void) {
        guard let request = APIRouter.userDetails(requestModel).asURLRequest else {
            assertionFailure()
            result(.failure(NetworkingError.unableToPerformRequest))
            return
        }
        manager.dataTask(with: request, dataTaskCompletion: { [weak self] response in
            self?.handle(response, result: result)
        })
        .resume()
    }
}
