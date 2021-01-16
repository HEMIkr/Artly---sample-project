//
//  UsersRepository.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 13/01/2021.
//

import Foundation
import NetworkingModule

final class UsersRepository {
    private let apiService: UsersAPIService = APIService()
    
    func getCreatorsToFollow(result: @escaping (Result<CreativesToFollow.Response, Error>) -> Void) {
        apiService.getCretorsToFollow(result: result)
    }
}
