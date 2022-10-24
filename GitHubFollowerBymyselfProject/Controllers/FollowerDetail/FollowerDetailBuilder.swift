//
//  FollowerDetailBuilder.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/25.
//

import UIKit

enum FollowerDetailTransition: Transition {
    case dismiss
    case gitHubProfile(FollowerDetailInformation)
    case gitHubFollowers(Follower)
}

final class FollowerDetailBuilder {
    class func build(follower: Follower, container: AppContainer) -> Module<FollowerDetailTransition, UIViewController> {
        let viewModel = FollowerDetailViewModel(followerBasicInfo: follower,
                                         localService: container.localSaveService,
                                         networkService: container.networkService)
        let viewController = FollowerDetailViewController(of: viewModel)
        return Module(viewController: viewController,
                      transitionPublisher: viewModel.transitionPublisher)
    }
}
