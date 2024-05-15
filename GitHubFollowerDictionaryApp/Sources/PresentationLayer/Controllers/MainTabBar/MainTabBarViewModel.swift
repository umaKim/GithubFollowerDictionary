//
//  MainTabBarViewModel.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/25.
//

import Combine
import Foundation

final public class MainTabBarViewModel: BaseViewModel {
    private(set) public lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<MainTabBarTransition, Never>()
    
    public override init() {
        super.init()
    }
}
