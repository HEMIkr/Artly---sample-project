//
//  UsersListTableViewController.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 14/01/2021.
//

import UIKit
import Models
import Extensions

protocol UsersListTableViewControllerDelegate: AnyObject {
    func usersListTableViewController(_ viewController: UsersListTableViewController, didSelect user: User)
    func usersListTableViewControllerRequestsRefresh(_ viewController: UsersListTableViewController)
}

final class UsersListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private enum Constants {
        static var inset: UIEdgeInsets { UIEdgeInsets(top: 20, left: 0, bottom: 50, right: 0) }
    }
    private var users: [User] = []
    weak var delegate: UsersListTableViewControllerDelegate?
    
    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UserTableViewCell.self))
        tableView.estimatedRowHeight = UserTableViewCell.cellHeight
        tableView.contentInset = Constants.inset
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshPulled), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    // MARK: - Endpoints
    
    func displayList(_ users: [User]) {
        func clearTableView() {
            let numberOfCells = tableView.numberOfRows(inSection: 0)
            self.users = []
            if numberOfCells > 0 {
                let indexPaths: [IndexPath] = (0..<numberOfCells).compactMap {
                    IndexPath(row: $0, section: 0)
                }
                tableView.beginUpdates()
                tableView.deleteRows(at: indexPaths, with: .automatic)
                tableView.endUpdates()
            }
        }
        
        func showNewContent() {
            self.users = users
            let numberOfCellsToShow = users.count
            if numberOfCellsToShow > 0 {
                let indexPaths: [IndexPath] = (0..<numberOfCellsToShow).compactMap { IndexPath(row: $0, section: 0) }
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: indexPaths, with: .automatic)
                self.tableView.endUpdates()
            }
        }
            
        clearTableView()
        showNewContent()
    }
    
    func showLoading() {
        tableView.refreshControl?.beginRefreshing()
    }
    
    func hideLoading() {
        tableView.refreshControl?.endRefreshing()
    }
    
    // MARK: - Actions
    
    @objc private func refreshPulled(_ sender: UIRefreshControl) {
        guard sender.isRefreshing else { return }
        delegate?.usersListTableViewControllerRequestsRefresh(self)
    }
    
    // MARK: = TableView methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UserTableViewCell.self), for: indexPath)
        if let cell = cell as? UserTableViewCell, let accordingUser = users[safe: indexPath.row] {
            cell.configure(using: accordingUser)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let accordingUser = users[safe: indexPath.row] else { return }
        delegate?.usersListTableViewController(self, didSelect: accordingUser)
    }
}
