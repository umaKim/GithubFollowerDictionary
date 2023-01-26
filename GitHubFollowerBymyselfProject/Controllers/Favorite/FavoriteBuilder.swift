//
//  FavoriteBuilder.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/25.
//
import Combine
import UIKit

enum FavoriteTransition: Transition {
    case tap(_ follower: Follower)
}

final class FavoriteBuiler {
    class func build(container: AppContainer) -> Module<FavoriteTransition, UIViewController> {
        let viewModel = FavoriteViewModel(localService: container.localSaveService)
        let viewController = FavoriteViewController(of: viewModel)
        return Module(
            viewController: viewController,
            transitionPublisher: viewModel.transitionPublisher
        )
    }
}
