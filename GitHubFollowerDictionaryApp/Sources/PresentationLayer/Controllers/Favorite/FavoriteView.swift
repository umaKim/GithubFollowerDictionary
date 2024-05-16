//
//  FavoriteView.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/09.
//

import UIKit

final class FavoriteView: UIView {
    //MARK: UI Objects
    private(set) lazy var tableView = UITableView()
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Configure TableView
extension FavoriteView{
    private func configureTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 4.0),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        tableView.rowHeight     = 100
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.identifier)
    }
}
