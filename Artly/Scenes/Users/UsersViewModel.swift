//
//  UsersViewModel.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 13/01/2021.
//

import Foundation
import Models

protocol UsersDataProvider: AnyObject {
    func getUsersList()
    func getFollowed(_ onlyFollowed: Bool)
}

final class UsersViewModel {
    
    // MARK: - Properties
    
    private unowned var viewBehaviour: UsersViewBehaviour
    private let repository: UsersRepository = .init()
    
    // MARK: - Lifecycle
    
    init(viewBehaviour: UsersViewBehaviour) {
        self.viewBehaviour = viewBehaviour
    }
    
    // MARK: - Helpers
    
    private func getUsers(_ onlyFollowed: Bool = false) {
        repository.getCreatorsToFollow { [weak self] result in
            switch result {
            case .failure(let error):
                self?.viewBehaviour.displayError(error)
            case .success(let responseModel):
                let followed = self?.repository.getFollowed() ?? []
                var users = responseModel.users
                users = users.compactMap { user in
                    user.setFollowed(followed.contains(user.id))
                    if onlyFollowed {
                        let ifFollowed = user.isFollowed ?? false
                        return ifFollowed ? user : nil
                    }
                    return user
                }
                self?.viewBehaviour.displayUsers(users)
            }
        }
    }
}

// MARK: - Protocol implementation
extension UsersViewModel: UsersDataProvider {
    func getFollowed(_ onlyFollowed: Bool) {
        getUsers(onlyFollowed)
    }
    
    func getUsersList() {
        getUsers()
    }
}
