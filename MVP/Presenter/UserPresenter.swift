//
// UserPresenter.swift
// MVP
//
// Created by Ravi kumar on 28/06/23.
//


import Foundation
import UIKit

protocol UserPresenterDelegate: AnyObject {
    func updatedUsers(users: [User])
}

class UserPresenter {
    
    private let httpClient:HTTPClientProtocol?
    weak var delegate: UserPresenterDelegate?
    
    init(client: HTTPClientProtocol) {
        httpClient = client
    }
    
    
    func getUsers() {
        httpClient?.request(url: Constants.URLConstants.users) { [weak self] (result:Result<UserData?,NetworkError>) in
            switch result {
            case .success(let users):
                if let users = users {
                    DispatchQueue.main.async {
                        self?.delegate?.updatedUsers(users: users.users)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        } 
    }
    
}
