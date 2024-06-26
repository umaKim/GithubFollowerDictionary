//
//  SceneDelegate.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/23.
//

import DependencyManager
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    var appContainer: AppContainerImplementation!
    var appCoordinator: AppCoordinator!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window                = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene   = windowScene
        
        guard let window      = window else { return }
        let appContainer      = AppContainerImplementation()
        appCoordinator        = AppCoordinator(window: window, container: appContainer)
        appCoordinator?.start()
    }
}
