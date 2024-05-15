//
//  FollowerDetailBuilder.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/25.
//

import DomainLayer
import UIKit

public enum FollowerDetailTransition: Transition {
    case dismiss
    case gitHubProfile(FollowerDetailInformation)
    case gitHubFollowers(Follower)
}
