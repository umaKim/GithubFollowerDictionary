//
//  GFLabel.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/24.
//

import UIKit

final class IGLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment  = textAlignment
        self.font           = UIFont.systemFont(ofSize: fontSize)
        configure()
    }
    
    func configure() {
        textColor = .label
        translatesAutoresizingMaskIntoConstraints = false
    }

}
