//
//  UsersViewModel.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 13/01/2021.
//

import Foundation
import Models
import NetworkingModule

protocol UsersDataProvider: AnyObject {
    func getUsersList()
}

final class UsersViewModel {
    private unowned var viewBehaviour: UsersViewBehaviour
    
    init(viewBehaviour: UsersViewBehaviour) {
        self.viewBehaviour = viewBehaviour
    }
    
    let repository: UsersRepository = .init()
    private var currentPage = 0
}

extension UsersViewModel: UsersDataProvider {
    
    func getUsersList() {
        repository.getCreatorsToFollow { [weak self] result in
            switch result {
            case .failure(let error):
                self?.viewBehaviour.displayError(error)
            case .success(let responseModel):
                self?.viewBehaviour.displayUsers(responseModel.users)
            }
        }
    }
}
