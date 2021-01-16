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
    func usersListTableViewController(didSelect user: User)
}

final class UsersListTableViewController: UITableViewController {
    
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
    }
    
    // MARK: - Endpoints
    func displayList(_ users: [User]) {
        self.users = users
        tableView.reloadData()
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
        delegate?.usersListTableViewController(didSelect: accordingUser)
    }
}
