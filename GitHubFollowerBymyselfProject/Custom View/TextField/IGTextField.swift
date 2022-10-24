//
//  GFTextField.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/23.
//

import UIKit

final class IGTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        layer.borderWidth   = 2
        layer.cornerRadius  = 10
        layer.borderColor   = UIColor.systemGray2.cgColor
        
        textAlignment       = .center
        placeholder         = "Enter username"
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
