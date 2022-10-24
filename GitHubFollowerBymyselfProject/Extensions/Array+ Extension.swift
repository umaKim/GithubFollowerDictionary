//
//  Array+ Extension.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/26.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
