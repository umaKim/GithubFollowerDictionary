//
//  AppContainerImpl.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/24.
//

import Foundation

protocol AppContainer: AnyObject {
    var networkService: NetworkServiceProtocol { get }
    var localSaveService: LocalServiceProtocol { get }
}

final class AppContainerImplementation: AppContainer {
    var networkService: NetworkServiceProtocol
    var localSaveService: LocalServiceProtocol
    
    init() {
        self.networkService   = NetworkService()
        self.localSaveService = LocalService()
    }
}
