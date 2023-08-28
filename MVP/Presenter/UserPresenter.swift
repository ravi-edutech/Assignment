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
    private var users: [User] = []
    
    init(client: HTTPClientProtocol) {
        httpClient = client
    }
    
    
    func getUsers() {
        
        httpClient?.request(url: URLConstants.users) { [weak self] (result:Result<[User]?,NetworkError>) in
            switch result {
            case .success(let users):
                if let users = users {
                    DispatchQueue.main.async {
                        self?.addUsers(users: users)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        } 
    }
    
    func getPosts(){
        httpClient?.request(url: URLConstants.posts) { [weak self] (result:Result<[Post]?, NetworkError>) in
            switch result{
            case .success(let posts):
                print(posts)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func addUsers(users: [User]){
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey:"users") == nil {
            userDefaults.set(Array<User>(), forKey:"users")
        }
       
        if let userJson = try? JSONEncoder().encode(users) {
            userDefaults.set(userJson, forKey: "users")
            self.delegate?.updatedUsers(users: users)
        }
        
    }
}
