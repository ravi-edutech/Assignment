//
// JokesViewController.swift
// MVP
//
// Created by Ravi kumar BHURI SINGH on 28/06/23.
//

import UIKit

class JokesViewController: UIViewController {

    lazy var jokePresenter: JokePresenter = JokePresenter()
    lazy var jokesView = JokesView(frame: self.view.frame)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view = jokesView
        jokePresenter.delegate = self
        Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(self.fetchJokes), userInfo: nil, repeats: true)
    }

    @objc func fetchJokes(){
        jokePresenter.getJokes()
    }
}

extension JokesViewController: JokePresenterDelegate{
    func updatedJokes (jokes: [String]) {
        self.jokesView.jokes = jokes
        self.jokesView.listView.reloadData()
    }
}

