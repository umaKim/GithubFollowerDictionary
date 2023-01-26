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

    private let network: NetworkService

    //MARK: - Init
    init(
        follower: Follower,
        network: NetworkService = NetworkService()
    ) {
        self.follower = follower
        self.network = network
        
        ProfileImageLoader.shared.loadImage(from: follower.avatar_url)
            .replaceError(with: UIImage(systemName: "person") ?? UIImage())
            .sink(receiveValue:  {[weak self] image in
                self?.imageSubject.send(image)
            })
            .store(in: &subscriptions)
    }
}
