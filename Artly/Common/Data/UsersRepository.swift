//
//  UsersRepository.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 13/01/2021.
//

import Foundation
import NetworkingModule
import Persistance
import Models

final class UsersRepository {
    private let apiService: UsersAPIService = APIService()
    private let persistence: PersistenceManager = PersistenceHandler()
    
    func getCreatorsToFollow(result: @escaping (Result<CreativesToFollow.Response, Error>) -> Void) {
        apiService.getCretorsToFollow(result: result)
    }
    
    func getUserDetails(_ userId: Int, result: @escaping (Result<UserDetails.Response, Error>) -> Void) {
        let requestModel = UserDetails.Request(id: userId)
        apiService.getUserDetails(requestModel, result: result)
    }
    
    func toggleFollow(user: User) -> Bool {
        let followModel = Followed(id: user.id)
        return persistence.toggle(followModel, key: String(describing: Followed.self))
    }
    
    func getIsFollowed(_ user: User, completion: @escaping (Bool) -> Void) {
        let followModel = Followed(id: user.id)
        let isFollowed = persistence.contains(followModel, key: String(describing: Followed.self))
        completion(isFollowed)
    }
    
    func getFollowed() -> [Int] {
        let followed = persistence.get(Followed.self, key: String(describing: Followed.self))
        return followed.compactMap { $0.id }
    }
}
