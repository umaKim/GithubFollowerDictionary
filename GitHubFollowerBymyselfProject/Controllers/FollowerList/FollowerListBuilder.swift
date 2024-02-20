//
//  FollowerListBuilder.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/25.
//

import UIKit

enum FollowerlistTransition: Transition {
    case tap(_ follower: Follower)
    case dismiss
}

final class FollowerListBuilder {
    class func build(userName: String, container: AppContainer) -> Module<FollowerlistTransition, UIViewController> {
        let viewModel = FollowerListViewModel(
            userName: userName,
            networkService: container.networkService,
            favoriteManager: container.localSaveService
        )
        let viewController = FollowerListViewController(of: viewModel)
        return Module(viewController: viewController,
                      transitionPublisher: viewModel.transitionPublisher)
    }
}
