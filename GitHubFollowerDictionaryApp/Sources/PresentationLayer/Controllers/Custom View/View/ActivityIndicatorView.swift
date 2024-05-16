//
//  ActivityIndicatorView.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/21.
//

import UIKit

final class ActivityIndicatorView: UIActivityIndicatorView {
    override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        
        setUp()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        color               = .white
        backgroundColor     = .systemGray5
        layer.cornerRadius  = 5.0
        hidesWhenStopped    = true
    }
}
