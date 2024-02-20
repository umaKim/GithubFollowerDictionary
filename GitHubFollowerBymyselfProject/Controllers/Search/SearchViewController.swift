//
//  ViewController.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/23.
//

import Combine
import UIKit

//MARK: Take care about naming more carefully
// size class ?? regular size, compact size
final class SearchViewController: BaseViewController<SearchViewModel> {
    //MARK: - UI Object
    private let contentView = SearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
    }
    
    //MARK: - Load View
    override func loadView() {
        view = contentView
    }
}

//MARK: - Binding
extension SearchViewController {
    private func binding() {
        func bindViewModelToView() {
            viewModel
                .$isValid
                .sink(receiveValue: { [weak self] in
                    self?.contentView.setGetFollowersButton($0)
                })
                .store(in: &cancellables)
        }
        
        func bindViewToViewModel() {
            contentView
                .actionPublisher
                .sink {[weak self] action in
                    guard let self = self else {return}
                    switch action {
                    case .searchDidTap:
                        self.viewModel.searchButtonDidTap()
                        
                    case .searchQuery(let query):
                        self.viewModel.userName = query
                    }
                }
                .store(in: &cancellables)
        }
        
        bindViewModelToView()
        bindViewToViewModel()
    }
}

//MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.searchButtonDidTap()
        return true
    }
}
