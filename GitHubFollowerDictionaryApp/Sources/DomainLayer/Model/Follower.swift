//
//  Follower.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/24.
//

import Foundation

//MARK: - FIX snake case

public struct Follower: Codable, Hashable {
    public var login: String
    public var avatar_url: String
    
    public init(login: String, avatar_url: String) {
        self.login = login
        self.avatar_url = avatar_url
    }
}

