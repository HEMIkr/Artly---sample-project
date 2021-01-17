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
    func fetchUserDetails()
    func getRegionToShow()
    func toggleFollow() -> Bool
    func isFollowed() -> Bool
}

final class UserDetailsViewModel {
    private unowned var viewBehaviour: UserDetailsViewBehaviour
    private var user: User
    
    init(viewBehaviour: UserDetailsViewBehaviour, user: User) {
        self.user = user
        self.viewBehaviour = viewBehaviour
    }
    
    let repository: UsersRepository = .init()
}

extension UserDetailsViewModel: UserDetailsDataProvider {
    func getUser() -> User {
        return user
    }
    
    func fetchUserDetails() {
        repository.getUserDetails(user.id) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.viewBehaviour.displayError(error)
            case .success(let responseModel):
                self?.user = responseModel.user
                self?.viewBehaviour.displayUserDetails(responseModel.user)
                self?.getRegionToShow()
            }
        }
    }
    
    func getRegionToShow() {
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
            }
        }
    }
    
    func toggleFollow() -> Bool {
        return repository.toggleFollow(user: user)
    }
    
    func isFollowed() -> Bool {
        return repository.isFollowed(user)
    }
}
