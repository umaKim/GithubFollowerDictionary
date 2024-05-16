//
//  FavoriteBuilder.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/25.
//
import DomainLayer
import Combine
import UIKit

public enum FavoriteTransition: Transition {
    case tap(_ follower: Follower)
}

//final class FavoriteBuiler {
//    class func build(container: AppContainer) -> Module<FavoriteTransition, UIViewController> {
//       
//    }
//}
