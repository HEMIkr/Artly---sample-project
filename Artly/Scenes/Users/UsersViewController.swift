//
//  UserViewController.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 13/01/2021.
//

import UIKit
import Models

protocol UsersViewBehaviour: ViewBehaviour {
    func displayUsers(_ users: [User])
}

final class UsersViewController: UIViewController {
    
    // MARK: - Properties
    
    private var dataProvider: UsersDataProvider!
    private var router: UsersRouter!
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setupDesign(.standard)
        dataProvider.getUsersList()
    }
    
    // MARK: - Setup
    
    private func setupScene() {
        self.dataProvider = UsersViewModel(viewBehaviour: self)
        self.router = UsersRouter(controller: self)
    }
    
    // MARK: - View building
    
    private func buildView() {
        view = UIView()
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        let tableViewController = UsersListTableViewController()
        tableViewController.delegate = self
        view.addConstraintedSubview(tableViewController.view)
        self.tableViewController = tableViewController
    }
    
    private func setupNavigationBar() {
        navigationItem.title = Strings.title.localized
        
        let builder = UsersViewBuilder()
        let (barItem, followedSwitch) = builder.buildBarItem()
        followedSwitch.addTarget(self, action: #selector(followedToggled), for: .valueChanged)
        navigationItem.rightBarButtonItem = barItem
    }
    
    // MARK: - Actions
    
    @objc private func followedToggled(_ sender: UISwitch) {
        dataProvider.getFollowed(sender.isOn)
    }
}

// MARK: - Scene communication methods
extension UsersViewController: UsersViewBehaviour {
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
