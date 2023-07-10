//
// JokePresenter.swift
// Assignment
//
// Created by Ravi kumar on 28/06/23.
//


import Foundation
import UIKit

protocol JokePresenterDelegate: AnyObject {
    func updatedJokes(jokes: [String])
}

class JokePresenter {
    
    private let httpClient: HTTPClient = HTTPClient()
    weak var delegate: JokePresenterDelegate?
    private var jokes: [String] = []
    
    init() {}
    
    
    func getJokes() {
        httpClient.getJoke { [weak self] result in
            switch result {
            case .success(let joke):
                if let joke = joke {
                    DispatchQueue.main.async {
                        self?.addNewJoke(joke: joke)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
        private func addNewJoke(joke: String){
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey:"jokes") == nil {
            userDefaults.set([], forKey:"jokes")
        }
        var jokes = userDefaults.object(forKey: "jokes") as? [String] ?? []
        
        if jokes.count == 10 {
            jokes.removeFirst()
        }
        jokes.append(joke)
        userDefaults.set(jokes, forKey: "jokes")
        self.delegate?.updatedJokes(jokes: jokes)
    }
}
