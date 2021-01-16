//
//  UsersRouter.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 13/01/2021.
//

import Foundation
import Models
import UIKit

protocol UsersRoutingLogic: RoutingLogic { }

final class UsersRouter {
    // MARK: - Nested types & properties
    typealias Destination = RoutingDestination
    enum RoutingDestination {
        case userDetails(User)
    }
    
    private weak var viewController: UIViewController?

    // MARK: - Lifecycle
    
    init(controller: UIViewController) {
        self.viewController = controller
    }
}

// MARK: - Routing protocol implementation
extension UsersRouter: UsersRoutingLogic {
    func navigate(to destination: RoutingDestination) {
        switch destination {
        case .userDetails(let user):
            routeToDetails(of: user)
        }
    }
}

// MARK: - Routing
extension UsersRouter {
    private func routeToDetails(of user: User) {
        let detailsViewController = UIViewController()
        detailsViewController.view.backgroundColor = .red
        viewController?.show(detailsViewController, sender: nil)
    }
}
