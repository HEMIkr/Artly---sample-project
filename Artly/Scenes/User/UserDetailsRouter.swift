//
//  UserDetailsRouter.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 16/01/2021.
//

import Foundation
import UIKit
import MapKit

protocol UserDetailsRoutingLogic: RoutingLogic { }

final class UserDetailsRouter {
    // MARK: - Nested types & properties
    typealias Destination = RoutingDestination
    enum RoutingDestination {
        case map(_ region: MKCoordinateRegion)
        case photos(_ urls: [URL])
    }
    
    private weak var viewController: UIViewController?

    // MARK: - Lifecycle
    
    init(controller: UIViewController) {
        self.viewController = controller
    }
}

// MARK: - Routing protocol implementation
extension UserDetailsRouter: UsersRoutingLogic {
    func navigate(to destination: RoutingDestination) {
        switch destination {
        case .map(let region):
            routeToMap(region)
        case .photos(let urls):
            routeToPhotos(urls)
        }
    }
}

// MARK: - Routing
extension UserDetailsRouter {
    
    private func routeToMap(_ region: MKCoordinateRegion) {
        let mapViewController = MapViewController(region)
        viewController?.present(NavigationController(rootViewController: mapViewController), animated: true, completion: nil)
    }
    
    private func routeToPhotos(_ urls: [URL]) {
        let photosViewController = UserPhotosViewController(urls)
        viewController?.present(NavigationController(rootViewController: photosViewController), animated: true, completion: nil)
    }
}
