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
}

final class UsersViewModel {
    private unowned var viewBehaviour: UsersViewBehaviour
    
    init(viewBehaviour: UsersViewBehaviour) {
        self.viewBehaviour = viewBehaviour
    }
    
    let repository: UsersRepository = .init()
}

extension UsersViewModel: UsersDataProvider {
    
    func getUsersList() {
        repository.getCreatorsToFollow { [weak self] result in
            switch result {
            case .failure(let error):
                self?.viewBehaviour.displayError(error)
            case .success(let responseModel):
                let followed = self?.repository.getFollowed() ?? []
                responseModel.users.forEach { $0.setFollowed(followed.contains($0.id)) }
                self?.viewBehaviour.displayUsers(responseModel.users)
            }
        }
    }
}
