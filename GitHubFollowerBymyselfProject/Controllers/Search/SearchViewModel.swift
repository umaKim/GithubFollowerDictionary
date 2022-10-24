//
//  SearchViewModel.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/08.
//
import Combine
import Foundation

final class SearchViewModel: BaseViewModel {
    
    //MARK: - Model
    @Published var userName: String           = ""
    @Published private(set) var isValid: Bool = false
    
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<SearchTransition, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Life Cycle
    override func onViewDidLoad() {
        super.onViewDidLoad()
        binding()
    }
    
    func searchButtonDidTap() {
        transitionSubject.send(.search(query: userName))
    }
}

//MARK: - Binding
extension SearchViewModel {
    private func binding() {
        $userName
            .sink { [weak self] in
                self?.isValid = !$0.isEmpty
            }.store(in: &cancellables)
    }
}
