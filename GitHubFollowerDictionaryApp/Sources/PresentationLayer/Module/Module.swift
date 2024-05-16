//
//  Module.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/26.
//

import UIKit
import Combine

public protocol Transition {}

public struct Module<T: Transition, V: UIViewController> {
    let viewController: V
    let transitionPublisher: AnyPublisher<T, Never>
    
    public init(viewController: V, transitionPublisher: AnyPublisher<T, Never>) {
        self.viewController = viewController
        self.transitionPublisher = transitionPublisher
    }
}
