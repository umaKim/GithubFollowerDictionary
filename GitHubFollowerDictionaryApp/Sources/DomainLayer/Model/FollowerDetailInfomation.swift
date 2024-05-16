//
//  FollowerDetailInfomation.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/30.
//

import Foundation

public struct FollowerDetailInformation: Decodable {
    public var avatarUrl: String
    public var login: String
    public var name: String?
    public var location: String?
    public var bio: String?
    
    public var followers: Int
    public var following: Int
    
    public var publicRepos: Int
    public var publicGists: Int
    
    public let htmlUrl: String
}
