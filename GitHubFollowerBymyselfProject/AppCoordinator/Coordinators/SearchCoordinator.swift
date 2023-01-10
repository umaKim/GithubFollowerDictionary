//
//  SearchCoordinator.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/25.
//

import Combine
import UIKit

final class SearchCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private(set) lazy var didFinishPublisher: AnyPublisher<Void, Never> = didFinishSubject.eraseToAnyPublisher()
    private let didFinishSubject = PassthroughSubject<Void, Never>()
    private var cancellable = Set<AnyCancellable>()
    
    private let container: AppContainer
    
    init(
        navigationController: UINavigationController,
        container: AppContainer
    ) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let module = SearchBuilder.build()
        module.transitionPublisher
            .sink { transition in
                switch transition {
                case .search(query: let term):
                    self.showFollowerList(of: term)
                }
            }
            .store(in: &cancellable)
        setRoot(module.viewController)
    }
    
    private func showFollowerList(of userName: String) {
        let coordinator = FollowerListCoordinator(
            navigationController: navigationController,
            container: container,
            userName: userName
        )
        addChild(coordinator: coordinator)
        coordinator.start()
    }
}
