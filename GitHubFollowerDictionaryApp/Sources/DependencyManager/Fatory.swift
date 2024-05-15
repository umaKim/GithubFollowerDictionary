//
//  File.swift
//  
//
//  Created by 김윤석 on 2024/02/22.
//

import PresentationLayer
import DomainLayer
import DataLayer

import UIKit
import Foundation

enum Factory {
    func buildMainTabBar(viewControllers: [UIViewController]) -> Module<MainTabBarTransition, UIViewController> {
        let viewModel = MainTabBarViewModel()
        let viewController = MainTabBarViewController(viewModel: viewModel, viewControllers: viewControllers)
        return Module(
            viewController: viewController,
            transitionPublisher: viewModel.transitionPublisher
        )
    }
    
    func buildFavorite(container: AppContainer) -> Module<FavoriteTransition, UIViewController> {
        let viewModel = FavoriteViewModel(localService: container.localSaveService)
        let viewController = FavoriteViewController(viewModel: viewModel)
        return Module(
            viewController: viewController,
            transitionPublisher: viewModel.transitionPublisher
        )
    }
    
    func buildFollowerDetail(follower: Follower, container: AppContainer) -> Module<FollowerDetailTransition, UIViewController> {
        let viewModel = FollowerDetailViewModel(followerBasicInfo: follower,
                                         localService: container.localSaveService,
                                         networkService: container.networkService)
        let viewController = FollowerDetailViewController(of: viewModel)
        return Module(viewController: viewController,
                      transitionPublisher: viewModel.transitionPublisher)
    }
    
    func buildSearch() -> Module<SearchTransition, UIViewController> {
        let viewModel = SearchViewModel()
        let viewController = SearchViewController(of: viewModel)
        return Module(viewController: viewController,
                      transitionPublisher: viewModel.transitionPublisher)
    }
    
    func buildFollowerList(userName: String, container: AppContainer) -> Module<FollowerlistTransition, UIViewController> {
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
