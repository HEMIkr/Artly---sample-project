//
//  UserDetailsViewModel.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 16/01/2021.
//

import Foundation
import Models
import MapKit
import Persistance

protocol UserDetailsDataProvider: AnyObject {
    func getUser() -> User
    func toggleFollow() -> Bool
    func getData()
}

final class UserDetailsViewModel {
    
    // MARK: - Properties
    
    private unowned var viewBehaviour: UserDetailsViewBehaviour
    private var user: User
    private let repository: UsersRepository = .init()
    private var dispatchGroup: DispatchGroup?
    
    // MARK: - Lifecycle
    
    init(viewBehaviour: UserDetailsViewBehaviour, user: User) {
        self.user = user
        self.viewBehaviour = viewBehaviour
    }
    
    // MARK: - Private methods
    
    private func fetchUserDetails(completion: @escaping (Error?) -> Void) {
        repository.getUserDetails(user.id) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.viewBehaviour.displayError(error)
            case .success(let responseModel):
                self?.user = responseModel.user
                completion(nil)
            }
        }
    }
    
    private func getRegionToShow(completion: @escaping (Error?) -> Void) {
        var address = user.city ?? ""
        if let country = user.country {
            address.append(" " + country)
        }
        
        guard address.isEmpty == false else {
            return
        }
        CLGeocoder().geocodeAddressString(address) { [weak self] placemarks, _ in
            if let location = placemarks?.first?.location {
                let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 20000, longitudinalMeters: 20000)
                self?.viewBehaviour.displayRegion(region)
                completion(nil)
            }
        }
    }
    
    private func updateIsFollowed(completion: @escaping (Error?) -> Void) {
        repository.getIsFollowed(user) { [weak self] isFollowed in
            self?.user.setFollowed(isFollowed)
            completion(nil)
        }
    }
    
}

// MARK: - Protocol implementation & endpoints
extension UserDetailsViewModel: UserDetailsDataProvider {
    func getUser() -> User {
        return user
    }
    
    func getData() {
        func perform(tasks: [(@escaping (Error?) -> Void) -> Void]) {
            self.dispatchGroup = DispatchGroup()
            tasks.forEach { task in
                self.dispatchGroup?.enter()
                task { error in
                    if let error = error {
                        self.viewBehaviour.displayError(error)
                    }
                    self.dispatchGroup?.leave()
                }
            }
            let timeout: TimeInterval = 5
            _ = self.dispatchGroup?.wait(timeout: .now() + timeout)
            self.dispatchGroup = nil
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            perform(tasks: [self.fetchUserDetails])
            perform(tasks: [self.getRegionToShow, self.updateIsFollowed])
            self.viewBehaviour.displayUserDetails(self.user)
        }
    }
    
    func toggleFollow() -> Bool {
        return repository.toggleFollow(user: user)
    }
}
