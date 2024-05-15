//
//  FollowerDetailViewController.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/29.
//
import SafariServices
import Combine
import UIKit

final public class FollowerDetailViewController: BaseViewController<FollowerDetailViewModel> {
    
    //MARK: - UI Object
    private let contentView = FollowerDetailView()
    
    public override init(of viewModel: FollowerDetailViewModel) {
        super.init(of: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Load View
    public override func loadView() {
        view = contentView
    }
    
    //MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBarButtons()
        bind()
    }
}

//MARK: - Bind
extension FollowerDetailViewController {
    private func bind() {
        func bindViewModelToView() {
            viewModel
                .$followerDetailInfo
                .compactMap({$0})
                .sink {[unowned self] in
                    self.contentView.setItemViews(with: $0)
                }
                .store(in: &cancellables)
            
            viewModel
                .$state
                .sink(receiveValue: {[weak self] state in
                    guard let self = self else { return }
                    switch state {
                    case .loading:
                        contentView.startAnimation
                        
                    case .finishedLoading:
                        contentView.endAnimation
                        
                    case .error(let error):
                        viewModel.dismiss()
                        showAlertPopUpOnMainThread(
                            title: "Error",
                            message: error.localizedDescription,
                            buttonTitle: "Ok"
                        )
                    }
                })
                .store(in: &cancellables)
            
            viewModel
                .successMessagePublisher
                .sink {[unowned self] message in
                    self.showAlertPopUpOnMainThread(
                        title: "Successfully added",
                        message: message,
                        buttonTitle: "Ok"
                    )
                }
                .store(in: &cancellables)
        }
        
        func bindViewToViewModel() {
            contentView.actionPublisher
                .sink {[unowned self] action in
                    switch action{
                    case .done:
                        self.viewModel.dismiss()
                    case .add:
                        self.viewModel.addToFavorite()
                    case .getFollowers:
                        self.viewModel.gitHubFollowersDidTap()
                    case .gitHubProfile:
                        self.viewModel.gitHubProfileDidTap()
                    }
                }
                .store(in: &cancellables)
        }
        
        bindViewModelToView()
        bindViewToViewModel()
    }
}

//MARK: - Configure NavigationBar Buttons
extension FollowerDetailViewController {
    private func configureNavigationBarButtons() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItems  = [ contentView.addToFavoriteButton ]
        navigationItem.leftBarButtonItems   = [ contentView.doneButton ]
    }
}
