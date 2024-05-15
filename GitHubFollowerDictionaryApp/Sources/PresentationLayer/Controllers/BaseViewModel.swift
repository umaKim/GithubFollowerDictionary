//
//  BaseViewModel.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/27.
//

import Foundation

public protocol ViewModel {
    func onViewDidLoad()
    func onViewWillAppear()
    func onViewDidAppear()
    func onViewWillDisappear()
    func onViewDidDisappear()
}

public class BaseViewModel: ViewModel {
    
    public func onViewDidLoad() { }
    public func onViewWillAppear() { }
    public func onViewDidAppear() { }
    public func onViewWillDisappear() { }
    public func onViewDidDisappear() { }
    
    deinit {
        debugPrint("deinit of ", String(describing: self))
    }
}
