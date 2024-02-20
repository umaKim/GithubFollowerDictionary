//
//  FollowerListViewController.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/24.
//
import CombineCocoa
import Combine
import UIKit

final class FollowerListViewController: BaseViewController<FollowerListViewModel> {
    
    private typealias DataSource    = UICollectionViewDiffableDataSource<Section, Follower>
    private typealias Snapshot      = NSDiffableDataSourceSnapshot<Section, Follower>
    
    enum Section { case main }
    
    //MARK: - UI Object
    private let contentView = FollowerListView()
    private var diffableDataSource: DataSource?
    
    //MARK: - Load View
    override func loadView() {
        view = contentView
    }
    
    deinit {
        UIImageView.removeCache()
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.collectionView.delegate = self
        
        configureNavigationBar()
        configureSearchController()
        configureDiffableDataSource()
        
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = viewModel.username
    }
}

//MARK: - Binding
extension FollowerListViewController {
    
    private func binding() {
        func bindViewModelToView() {
            viewModel.$followers
                .receive(on: RunLoop.main)
                .sink { [unowned self] _ in self.updateData()}
                .store(in: &cancellables)
            
            viewModel.$state
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] in
                    self?.stateHandler(state: $0)
                })
                .store(in: &cancellables)
            
            viewModel.errorMessagePublisher
                .receive(on: RunLoop.main)
                .sink { [unowned self] in
                    self.showAlertPopUpOnMainThread(title: "Error", message: $0, buttonTitle: "ok")
                }
                .store(in: &cancellables)
        }
        
        func bindViewToViewModel() {
            contentView.actionPublisher
                .sink { [unowned viewModel] action in
                    switch action {
                    case .add:
                        viewModel.addToFavorite()
                    case .searchQuery(let query):
                        viewModel.fetchFollowers(of: query)
                        
                    case .dismiss:
                        viewModel.dismiss()
                    }
                }
                .store(in: &cancellables)
        }
        
        bindViewModelToView()
        bindViewToViewModel()
    }
}

//MARK: - Navigation Bar Button
extension FollowerListViewController {
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = contentView.addToFavoriteButton
        navigationItem.leftBarButtonItem = contentView.backButton
    }
}

//MARK: - UISearchBarDelegate
extension FollowerListViewController: UISearchBarDelegate {
    private func configureSearchController() {
        contentView.searchController.searchBar.delegate = self
        navigationItem.searchController                 = contentView.searchController
    }
}

//MARK: - Configure DiffableDataSource
extension FollowerListViewController {
    
    private func configureDiffableDataSource() {
        diffableDataSource = DataSource(collectionView: contentView.collectionView, cellProvider: { collectionView, indexPath, follower in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerListCell.identifier, for: indexPath) as? FollowerListCell else { return UICollectionViewCell() }
            cell.viewModel = FollowerListCellViewModel(follower: follower)
            return cell
        })
    }
    
    private func updateData() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.followers)
        self.diffableDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - Handlers
extension FollowerListViewController {
    private func stateHandler(state: FollowListViewState) {
        switch state {
        case .loading:
            contentView.loadingView.isHidden = false
            contentView.loadingView.startAnimating()
            
        case .finishedLoading:
            contentView.loadingView.isHidden = true
            contentView.loadingView.stopAnimating()
            
        case.error(let error):
            self.showAlertPopUpOnMainThread(title: "Error", message: error.localizedDescription, buttonTitle: "Ok")
        }
    }
}

//MARK: - UICollectionViewDelegate
extension FollowerListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectAt(indexPath: indexPath)
    }
}
