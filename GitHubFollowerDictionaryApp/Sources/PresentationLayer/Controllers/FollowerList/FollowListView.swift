//
//  FollowerListView.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/09.
//
import CombineCocoa
import Combine
import UIKit

enum FollowerListViewAction {
    case add
    case searchQuery(String)
    case dismiss
}

final class FollowerListView: UIView {
    //MARK: - UI Objects
    private(set) lazy var searchController    = UISearchController()
    private(set) lazy var collectionView      = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    private(set) lazy var loadingView         = ActivityIndicatorView(style: .medium)
    
    private(set) lazy var addToFavoriteButton = UIBarButtonItem(title: "Add", menu: nil)
    private(set) lazy var backButton = UIBarButtonItem(image: .init(systemName: "chevron.left"), menu: nil)
    
    private var collectionViewLayout: UICollectionViewLayout {
        let width                   = UIScreen.main.bounds.width
        let padding: CGFloat        = 12
        let minimumInsets: CGFloat  = 10
        var itemWidth               = width - (padding * 2) - (minimumInsets * 2)
        itemWidth                   = itemWidth / 3
        let flowLayout              = UICollectionViewFlowLayout()
        flowLayout.sectionInset     = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize         = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }
    
    private(set) lazy var actionPublisher   = actionSubject.eraseToAnyPublisher()
    private let actionSubject               = PassthroughSubject<FollowerListViewAction, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        
        configureSearchController()
        configureCollectionView()
        
        bind()
    }
    
    private func bind() {
        searchController
            .searchBar
            .searchTextField
            .textPublisher
            .debounce(for: .milliseconds(1000), scheduler: RunLoop.main)
            .receive(on: RunLoop.main)
            .compactMap({$0})
            .sink { [unowned self] query in
                self.actionSubject.send(.searchQuery(query))
            }
            .store(in: &cancellables)
        
        addToFavoriteButton
            .tapPublisher
            .sink { [unowned self] _ in
                self.actionSubject.send(.add)
            }
            .store(in: &cancellables)
        
        backButton
            .tapPublisher
            .sink { [unowned self] _ in
                self.actionSubject.send(.dismiss)
            }
            .store(in: &cancellables)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Configure UI
extension FollowerListView {
    private func configureSearchController() {
        searchController.searchBar.placeholder                = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.showsSearchResultsController         = true
    }
    
    private func configureCollectionView() {
        collectionView.backgroundColor = .systemBackground
        
        [collectionView, loadingView]
            .forEach {[weak self] in
                self?.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
        
        collectionView.register(FollowerListCell.self, forCellWithReuseIdentifier: FollowerListCell.identifier)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingView.heightAnchor.constraint(equalToConstant: 50),
            loadingView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
