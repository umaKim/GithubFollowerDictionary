//
//  FavoriteViewController.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/23.
//
import Combine
import UIKit

final public class FavoriteViewController: BaseViewController<FavoriteViewModel> {

    //MARK: - UI Object
    private let contentView = FavoriteView()
    
//    //MARK: - ViewModel
//    private let viewModel: FavoriteViewModel
    
//    //MARK: - Subscription
//    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Init
    public init(viewModel: FavoriteViewModel) {
        super.init(of: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = contentView
    }
    
    //MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite"
        
        binding()
        configureViewController()
        setUpTableView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavoriteList()
        contentView.tableView.reloadData()
    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}

//MARK: - Binding
extension FavoriteViewController {
    private func binding() {
        func bindViewModelToView() {
            viewModel.errorMessage
                .sink {[weak self] in
                    self?.showAlertPopUpOnMainThread(title: "Error",
                                                     message: $0.rawValue,
                                                     buttonTitle: "Ok")
                }.store(in: &cancellables)
        }
        
        bindViewModelToView()
    }
}

extension FavoriteViewController {
    private func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setUpTableView() {
        contentView.tableView.dataSource = self
        contentView.tableView.delegate   = self
    }
}

//MARK: - UITableViewDataSource
extension FavoriteViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.favorites.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.identifier) as? FavoriteCell else {return UITableViewCell() }
        cell.viewModel = FollowerListCellViewModel(follower: viewModel.favorites[indexPath.row])
        return cell
    }
}

//MARK: - UITableViewDelegate
extension FavoriteViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectAt(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let follower = viewModel.favorites[indexPath.item]
        viewModel.remove(follower: follower)
        contentView.tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

