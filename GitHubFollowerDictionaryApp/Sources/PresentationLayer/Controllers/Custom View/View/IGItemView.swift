//
//  ItemView.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/29.
//

import UIKit

class IGItemView: UIView {
    
    let imageSymbol = UIImageView()
    let titleLabel  = IGTitleLabel(textAlignment: .center, fontSize: 16)
    let countLabel  = IGTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(imageSymbol)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        imageSymbol.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageSymbol.topAnchor.constraint(equalTo: topAnchor),
            imageSymbol.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageSymbol.widthAnchor.constraint(equalToConstant: 20),
            imageSymbol.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: imageSymbol.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageSymbol.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            countLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
}
