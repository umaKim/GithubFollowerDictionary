//
//  MainTabBarCoordinator.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/25.
//
import Combine
import UIKit

final class MainTabBarCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private(set) lazy var didFinishPublisher: AnyPublisher<Void, Never> = didFinishSubject.eraseToAnyPublisher()
    private let didFinishSubject = PassthroughSubject<Void, Never>()
    
    private let container: AppContainer
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        navigationController: UINavigationController,
        container: AppContainer
    ) {
        self.navigationController  = navigationController
        self.container             = container
    }
    
    func start() {
        setUpSearchCoordinator()
        setUpFavoriteCoordinator()
        
        let controllers = childCoordinators.map { $0.navigationController }
        let module = MainTabBarBuilder.build(viewControllers: controllers)
        setRoot(module.viewController)
    }
    
    private func setUpSearchCoordinator() {
        let navController = UINavigationController()
        navController.tabBarItem = .init(
            title: "Search",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        let coordinator = SearchCoordinator(navigationController: navController, container: container)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    private func setUpFavoriteCoordinator() {
        let navController = UINavigationController()
        navController.tabBarItem = .init(
            title: "Favorite",
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
        )
        let coordinator = FavoriteCoordinator(navigationController: navController, container: container)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
