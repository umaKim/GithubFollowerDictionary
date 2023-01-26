//
//  FavoriteCoordinator.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/25.
//

import SafariServices
import Combine
import UIKit

final class FavoriteCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private(set) lazy var didFinishPublisher: AnyPublisher<Void, Never> = didFinishSubject.eraseToAnyPublisher()
    private let didFinishSubject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    private let container: AppContainer
    
    init(navigationController: UINavigationController,
         container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let module = FavoriteBuiler.build(container: container)
        module.transitionPublisher
            .sink { transition in
                switch transition {
                case .tap(let follower):
                    self.showFollowerDetail(of: follower)
                }
            }
            .store(in: &cancellables)
        setRoot(module.viewController)
    }
    
    func showFollowerDetail(of follower: Follower) {
        let coordinator = FollowerDetailCoordinaotr(
            navigationController: navigationController,
            container: container,
            follower: follower
        )
        coordinator.didFinishPublisher
            .sink { [weak self] in
                self?.removeChild(coordinator: coordinator)
            }
            .store(in: &cancellables)
        addChild(coordinator: coordinator)
        coordinator.start()
    }
}
