//
//  Follower.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/24.
//

import Foundation

//MARK: - FIX snake case

struct Follower: Codable, Hashable {
    var login: String
    var avatar_url: String
    
//    enum codingKeys: String, CodingKeys{
//        case
//    }
}

