//
//  FollowerDetailCoordinator.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/26.
//
import SafariServices
import Combine
import UIKit

final class FollowerDetailCoordinaotr: Coordinator{
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private(set) lazy var didFinishPublisher: AnyPublisher<Void, Never> = didFinishSubject.eraseToAnyPublisher()
    private let didFinishSubject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    private let container: AppContainer
    private let follower: Follower
    
    init(navigationController: UINavigationController,
         container: AppContainer,
         follower: Follower) {
        self.navigationController = navigationController
        self.container = container
        self.follower = follower
    }
    
    func start() {
        let module = FollowerDetailBuilder.build(follower: follower, container: container)
        module.transitionPublisher
            .sink { transition in
                switch transition {
                case .dismiss:
                    self.dismiss()
                    self.didFinishSubject.send()
                    
                case .gitHubProfile(let follower):
                    self.dismiss()
                    self.didFinishSubject.send()
                    self.presentSafari(of: follower.htmlUrl)
                    
                case .gitHubFollowers(let follower):
                    self.dismiss()
                    self.didFinishSubject.send()
                    self.showFollowerList(of: follower)
                }
            }
            .store(in: &cancellables)
        present(UINavigationController(rootViewController: module.viewController))
    }
    
    private func presentSafari(of urlString: String) {
        guard let url =  URL(string: urlString) else { return }
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemBlue
        present(safariVC)
    }
    
    func showFollowerList(of follower: Follower) {
        let coordinator = FollowerListCoordinator(navigationController: navigationController, container: container, userName: follower.login)
        addChild(coordinator: coordinator)
        coordinator.start()
    }
}
