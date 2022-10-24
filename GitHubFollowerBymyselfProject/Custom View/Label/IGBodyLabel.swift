//
//  GFBodyLabel.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/29.
//

import UIKit

final class IGBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        
        self.textAlignment = textAlignment
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.font = UIFont.preferredFont(forTextStyle: .body)
        numberOfLines = 5
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
