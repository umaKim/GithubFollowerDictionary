//
//  GFImageView.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/24.
//

import UIKit

class IGImageView: UIImageView {
    
    let imagePlaceholder = UIImage(systemName: "person")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius      = 10
        clipsToBounds           = true
        image                   = imagePlaceholder
        translatesAutoresizingMaskIntoConstraints = false
    }
}
