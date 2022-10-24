//
//  Module.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/26.
//

import UIKit
import Combine

protocol Transition {}

struct Module<T: Transition, V: UIViewController> {
    let viewController: V
    let transitionPublisher: AnyPublisher<T, Never>
}
