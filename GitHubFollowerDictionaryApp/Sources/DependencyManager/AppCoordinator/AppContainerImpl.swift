//
//  AppContainerImpl.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/24.
//

import DataLayer
import Foundation

public protocol AppContainer: AnyObject {
    var networkService: NetworkServiceProtocol { get }
    var localSaveService: LocalServiceProtocol { get }
}

final public class AppContainerImplementation: AppContainer {
    public var networkService: NetworkServiceProtocol
    public var localSaveService: LocalServiceProtocol
    
    public init() {
        self.networkService   = NetworkService()
        self.localSaveService = LocalService()
    }
}
