//
//  UserViewController.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 13/01/2021.
//

import UIKit
import Models

protocol UsersViewBehaviour: AnyObject {
    func displayError(_ error: Error)
    func displayUsers(_ users: [User])
}

final class UsersViewController: UIViewController {
    private var dataProvider: UsersDataProvider?
    private var router: UsersRouter?
    
    private var tableViewController: UsersListTableViewController?
    
    // MARK: - Lifecycle
    
    required init() {
        super.init(nibName: nil, bundle: nil)
        setupScene()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupScene()
    }
    
    override func loadView() {
        buildView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataProvider?.getUsersList()
    }
    
    // MARK: - Setup
    
    private func setupScene() {
        self.dataProvider = UsersViewModel(viewBehaviour: self)
        self.router = UsersRouter(controller: self)
    }
    
    // MARK: - View building
    
    private func buildView() {
        view = UIView()
        navigationItem.title = Strings.title.localized
        let tableViewController = UsersListTableViewController()
        tableViewController.delegate = self
        view.addConstraintedSubview(tableViewController.view)
        self.tableViewController = tableViewController
    }
}

// MARK: - Scene communication methods
extension UsersViewController: UsersViewBehaviour {
    func displayError(_ error: Error) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
            alertController.addAction(.init(title: Strings.ok.localized, style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func displayUsers(_ users: [User]) {
        DispatchQueue.main.async {
            self.tableViewController?.displayList(users)
        }
    }
}

// MARK: - Users List controller delegate
extension UsersViewController: UsersListTableViewControllerDelegate {
    func usersListTableViewController(didSelect user: User) {
        router?.navigate(to: .userDetails(user))
    }
}