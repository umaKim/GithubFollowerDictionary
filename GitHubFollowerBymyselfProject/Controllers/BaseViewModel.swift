//
//  BaseViewModel.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/27.
//

import Foundation

protocol ViewModel {
    func onViewDidLoad()
    func onViewWillAppear()
    func onViewDidAppear()
    func onViewWillDisappear()
    func onViewDidDisappear()
}

class BaseViewModel: ViewModel {
    
    func onViewDidLoad() { }
    func onViewWillAppear() { }
    func onViewDidAppear() { }
    func onViewWillDisappear() { }
    func onViewDidDisappear() { }
    
    deinit {
        debugPrint("deinit of ", String(describing: self))
    }
}
