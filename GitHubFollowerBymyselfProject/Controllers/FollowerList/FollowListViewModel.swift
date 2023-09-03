//
//  FollowerListViewModel.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/09.
//

import Combine
import Foundation

enum FollowListViewState {
    case loading
    case finishedLoading
    case error(GFError)
}

final class FollowerListViewModel: BaseViewModel {

    //MARK: - Models
    private (set) var username: String
    @Published private(set) var followers: [Follower]           = []
    @Published private(set) var filteredFollowers: [Follower]   = []
    @Published private(set) var isSearching                     = false
    @Published private(set) var state: FollowListViewState      = .loading
    
    private(set) lazy var errorMessagePublisher = errorMessageSubject.eraseToAnyPublisher()
    private let errorMessageSubject             = PassthroughSubject<String, Never>()
    
    private(set) lazy var transitionPublisher   = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject               = PassthroughSubject<FollowerlistTransition, Never>()
    
    //MARK: - AnyCancellable
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Protocols
    private let networkService: NetworkServiceProtocol
    private let favoriteManager: LocalServiceProtocol
    
    //MARK: - Init
    init(
        userName: String,
        networkService: NetworkServiceProtocol,
        favoriteManager: LocalServiceProtocol
    ) {
        self.username        = userName
        self.networkService  = networkService
        self.favoriteManager = favoriteManager
        super.init()
        
        fetchFollowers(of: username)
    }
    
    func didSelectAt(indexPath: IndexPath) {
        let follower = isSearching ? filteredFollowers[indexPath.item] : followers[indexPath.item]
        transitionSubject.send(.tap(follower))
    }
}

//MARK: - Networking
extension FollowerListViewModel {
    func fetchFollowers(of userName: String) {
        guard userName != "" else { return }
        state = .loading
        networkService.fetchFollowerList(of: userName)
            .sink(
                receiveCompletion: fetchCompletion,
                receiveValue: receiveValue
            )
            .store(in: &cancellables)
    }
    
    private func fetchCompletion(completion: (Subscribers.Completion<GFError>)) {
        switch completion {
        case .finished:
            self.state = .finishedLoading
            
        case .failure(_):
            self.state = .error(.error)
        }
    }
    
    private func receiveValue(followers: [Follower]) {
        self.followers = followers
    }
    
    func addToFavorite() {
        state = .loading

        let fetchCompletionValue: (
            Subscribers.Completion<GFError>
        ) -> Void = {[unowned self] completion in
            switch completion {
            case .finished:
                self.state = .finishedLoading

            case .failure(_):
                self.state = .error(.error)
            }
        }

        let returnValue: (FollowerDetailInformation) -> Void = {[weak self] followerInfo in
            let follower = Follower(login: followerInfo.login, avatar_url: followerInfo.avatarUrl)
            self?.favoriteManager.update(byAdding: follower)
        }

        networkService.fetchFollowerDetail(of: username)
            .sink(
                receiveCompletion: fetchCompletionValue,
                receiveValue: returnValue
            )
            .store(in: &cancellables)
    }
}
