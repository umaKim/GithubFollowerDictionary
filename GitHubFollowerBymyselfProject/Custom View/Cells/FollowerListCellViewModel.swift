//
//  FollowerListCellViewModel.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/23.
//
import Combine
import UIKit

class FollowerListCellViewModel {
    
    //MARK: - Model
    private(set) lazy var imagePublisher = imageSubject.eraseToAnyPublisher()
    private let imageSubject = PassthroughSubject<UIImage, Never>()

    @Published private(set) var follower: Follower
    
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: - Init
    init(follower: Follower) {
        self.follower = follower
    }
}
