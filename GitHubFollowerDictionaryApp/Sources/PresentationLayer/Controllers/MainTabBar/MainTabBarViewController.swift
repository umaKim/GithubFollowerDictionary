//
//  MainTabBarViewController.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/25.
//

import UIKit

final public class MainTabBarViewController: UITabBarController {
    
    //MARK: - ViewModel
    private let viewModel: MainTabBarViewModel
    
    //MARK: - Init
    public init(viewModel: MainTabBarViewModel, viewControllers: [UIViewController]) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
