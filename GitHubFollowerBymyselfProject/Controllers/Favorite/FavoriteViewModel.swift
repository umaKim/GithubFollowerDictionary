//
//  FavoriteViewModel.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/09.
//
import Combine
import Foundation

final class FavoriteViewModel: BaseViewModel {
    
    //MARK: - Protocol
    private let localService: LocalServiceProtocol
    
    //MARK: - Models
    private(set) var favorites      = [Follower]()
    private(set) var errorMessage   = PassthroughSubject<GFError, Never>()
    
    private(set) lazy var transitionPublisher   = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject               = PassthroughSubject<FavoriteTransition, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Init
    init(localService: LocalServiceProtocol) {
        self.localService = localService
        super.init()
        fetchFavoriteList()
    }
    
    func fetchFavoriteList() {
        favorites = localService.read()
    }
    
    func remove(follower: Follower) {
        localService.delete(follower: follower)
            .sink {[weak self] completion in
                switch completion {
                case .failure:
                    self?.errorMessage.send(.error)
                case .finished:
                    return
                }
            } receiveValue: {[weak self] _ in
                self?.favorites.removeAll { $0.login == follower.login }
            }
            .store(in: &cancellables)
    }
    
    func didSelectAt(indexPath: IndexPath) {
        let follower = favorites[indexPath.row]
        transitionSubject.send(.tap(follower))
    }
}
