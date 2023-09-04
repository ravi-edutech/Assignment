//
// UsersViewController.swift
// MVP
//
// Created by Ravi kumar BHURI SINGH on 28/06/23.
//

import UIKit

class UsersViewController: UIViewController {

    lazy var httpClientProtcolType:HTTPClientProtocol = HTTPClient()
    lazy var userPresenter: UserPresenter = UserPresenter(client: httpClientProtcolType)
    lazy var usersView = UsersView(frame: self.view.frame)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = usersView
        userPresenter.delegate = self
        userPresenter.getUsers()
    }
}

extension UsersViewController: UserPresenterDelegate{
    
    func updatedUsers(users: [User]) {
        self.usersView.users = users
        self.usersView.listView.reloadData()
    }
}


