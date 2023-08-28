//
// UsersViewController.swift
// MVP
//
// Created by Ravi kumar BHURI SINGH on 28/06/23.
//

import UIKit

class UsersViewController: UIViewController {

    lazy var userPresenter: UserPresenter = UserPresenter(client: HTTPClientFactory.create())
    lazy var usersView = UsersView(frame: self.view.frame)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = usersView
        userPresenter.delegate = self
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.fetchUsers), userInfo: nil, repeats: false)
        
    }

    @objc func fetchUsers(){
        userPresenter.getUsers()
    }
}

extension UsersViewController: UserPresenterDelegate{
    
    func updatedUsers(users: [User]) {
        self.usersView.users = users
        self.usersView.listView.reloadData()
    }
}

