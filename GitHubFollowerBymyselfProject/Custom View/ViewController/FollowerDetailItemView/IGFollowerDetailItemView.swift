//
//  IGFollowerDetailItemView.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/29.
//

import UIKit

class IGFollowerDetailItemView: UIView {

    let stackView = UIStackView()
    let itemOne = IGItemView()
    let itemTwo = IGItemView()
    let button = IGButton()
    
    init(){
        super.init(frame: .zero)
        
        configureViewController()
        configureStackView()
        configureUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViewController() {
        layer.cornerRadius = 18
    }
    
    private func configureStackView() {
        stackView.axis              = .horizontal
        stackView.distribution      = .equalSpacing
        
        stackView.addArrangedSubview(itemOne)
        stackView.addArrangedSubview(itemTwo)
    }
    
    private func configureUILayout() {
        addSubview(stackView)
        addSubview(button)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            button.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: padding),
            button.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -padding),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
