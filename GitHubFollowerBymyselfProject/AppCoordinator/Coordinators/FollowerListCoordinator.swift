//
//  FollowerListCoordinator.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/25.
//

//import SafariServices
import Combine
import UIKit

final class FollowerListCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private(set) lazy var didFinishPublisher: AnyPublisher<Void, Never> = didFinishSubject.eraseToAnyPublisher()
    private let didFinishSubject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    private let container: AppContainer
    private var userName: String
    
    init(
        navigationController: UINavigationController,
        container: AppContainer,
        userName: String
    ) {
        self.navigationController = navigationController
        self.container = container
        self.userName = userName
    }
    
    func start() {
        let module = FollowerListBuilder.build(
            userName: userName,
            container: container
        )
        module.transitionPublisher
            .sink { [weak self] transition in
                switch transition {
                case .tap(follower: let follower):
                    self?.showFollowerDetail(of: follower)
                }
            }.store(in: &cancellables)
        push(module.viewController)
    }
    
    func showFollowerDetail(of follower: Follower) {
        let coordinaotr = FollowerDetailCoordinaotr(
            navigationController: navigationController,
            container: container,
            follower: follower
        )
        coordinaotr.didFinishPublisher
            .sink { [weak self] in
                self?.removeChild(coordinator: coordinaotr)
            }
            .store(in: &cancellables)
        addChild(coordinator: coordinaotr)
        coordinaotr.start()
    }
}
