//
//  FollowerDetailViewModel.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/09.
//
import Combine
import Foundation

final class FollowerDetailViewModel: BaseViewModel {
    
    //MARK: - Model
    @Published private (set) var state: FollowListViewState     = .loading
    @Published private (set) var followerDetailInfo: FollowerDetailInformation?
    
    private(set) lazy var transitionPublisher       = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject                   = PassthroughSubject<FollowerDetailTransition, Never>()
    
    private(set) lazy var successMessagePublisher   = successMessageSubject.eraseToAnyPublisher()
    private let successMessageSubject               = PassthroughSubject<String,Never>()
    
    private let followerBasicInfo: Follower
    
    //MARK: - Protocols
    private let localService: LocalServiceProtocol
    private let networkService: NetworkServiceProtocol
    
    //MARK: -Subscription
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: - Init
    init(followerBasicInfo: Follower,
         localService: LocalServiceProtocol,
         networkService: NetworkServiceProtocol) {
        self.followerBasicInfo = followerBasicInfo
        self.localService = localService
        self.networkService  = networkService
        super.init()
        getFollowerDetailInfo()
    }
    
    func dismiss() {
        transitionSubject.send(.dismiss)
    }
    
    func gitHubFollowersDidTap(){
        transitionSubject.send(.gitHubFollowers(followerBasicInfo))
    }
    
    func gitHubProfileDidTap() {
        guard let followerDetailInfo = followerDetailInfo else { return }
        transitionSubject.send(.gitHubProfile(followerDetailInfo))
    }
}

extension FollowerDetailViewModel {
    func addToFavorite() {
        self.state = .loading
        localService.update(byAdding: followerBasicInfo)
            .sink { [unowned self] completion in
                switch completion {
                case .finished:
                    self.state = .finishedLoading
                    self.successMessageSubject.send("Successfully added")
                    
                case .failure:
                    self.state = .error(.error)
                }
            } receiveValue: { _ in}
            .store(in: &cancellable)
    }
}

//MARK: - Handler
extension FollowerDetailViewModel {
    private func fetchCompletionValue (completion: Subscribers.Completion<GFError>) {
        switch completion {
        case .finished:
            state = .finishedLoading
            
        case .failure:
            state = .error(.error)
        }
    }
    
    private func returnValue(followerDetailInfo: FollowerDetailInformation) {
        self.followerDetailInfo = followerDetailInfo
    }
}

extension FollowerDetailViewModel {
    private func getFollowerDetailInfo() {
        state = .loading
        
        self.networkService
            .fetchFollowerDetail(of: followerBasicInfo.login)
            .sink(receiveCompletion: fetchCompletionValue,
                  receiveValue: returnValue)
            .store(in: &self.cancellable)
    }
}
