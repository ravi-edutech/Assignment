//
// JokeCell.swift
// Assignment
//
// Created by Ravi kumar on 28/06/23.
//


import UIKit

class JokeCell: UITableViewCell {

    let jokeLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textAlignment = .left
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

        var item: String? {
        didSet {
            guard let item = item else { return }
            setItem(item: item)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        selectionStyle = .gray
        contentView.addSubview(jokeLabel)

        let padding: CGFloat = 10

        NSLayoutConstraint.activate([
            jokeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            jokeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            jokeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: jokeLabel.bottomAnchor, constant: padding)
        ])
    }

    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setItem( item: String) {
        jokeLabel.text = item
    }
}

