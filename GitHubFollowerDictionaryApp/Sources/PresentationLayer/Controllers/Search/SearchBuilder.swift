//
//  SearchBuilder.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/24.
//

import UIKit

public enum SearchTransition: Transition {
    case search(query: String)
}
//
//final class SearchBuilder {
//    class func build() -> Module<SearchTransition, UIViewController> {
//        let viewModel = SearchViewModel()
//        let viewController = SearchViewController(of: viewModel)
//        return Module(viewController: viewController,
//                      transitionPublisher: viewModel.transitionPublisher)
//    }
//}
