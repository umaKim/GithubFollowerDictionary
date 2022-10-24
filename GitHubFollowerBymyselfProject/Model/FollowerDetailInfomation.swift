//
//  FollowerDetailInfomation.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/30.
//

import Foundation

struct FollowerDetailInformation: Decodable {
    var avatarUrl: String
    var login: String
    var name: String?
    var location: String?
    var bio: String?
    
    var followers: Int
    var following: Int
    
    var publicRepos: Int
    var publicGists: Int
    
    let htmlUrl: String
}
