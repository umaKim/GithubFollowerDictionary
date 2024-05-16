//
//  AppCoordinator.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/24.
//
import Combine
import UIKit

final public class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private(set) lazy var didFinishPublisher: AnyPublisher<Void, Never> = didFinishSubject.eraseToAnyPublisher()
    private let didFinishSubject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    private let window: UIWindow
    private let container: AppContainer
    
    public init(
        window: UIWindow,
        navigationController: UINavigationController = UINavigationController(),
        container: AppContainer
    ) {
        self.window = window
        self.navigationController = navigationController
        self.container = container
    }
    
    public func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        mainFlow()
    }
    
    private func mainFlow() {
        let mainCoordinator = MainTabBarCoordinator(
            navigationController: navigationController,
            container: container
        )
        mainCoordinator.didFinishPublisher
            .sink {[weak self] in
            self?.removeChild(coordinator: mainCoordinator)
        }
        .store(in: &cancellables)
        childCoordinators.append(mainCoordinator)
        mainCoordinator.start()
    }
    
    deinit {
        print("deinit AppCoordinator")
    }
}
