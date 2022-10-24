//
//  FollowerDetailView.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/09.
//
import CombineCocoa
import Combine
import UIKit

enum FollowerDetailAction {
    case done
    case add
    case getFollowers
    case gitHubProfile
}

final class FollowerDetailView: UIView {
    //MARK: - UI Objects
    private(set) lazy var addToFavoriteButton = UIBarButtonItem(title: "Add", menu: .none)
    private(set) lazy var doneButton = UIBarButtonItem(title: "Done", menu: .none)
    
    private let headerView      = FollowerDetailHeaderView()
    private let itemOneView     = IGInfoContainerView()
    private let itemTwoView     = IGInfoContainerView()
    
    private(set) lazy var loadingView     = ActivityIndicatorView(style: .medium)
    
    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject             = PassthroughSubject<FollowerDetailAction, Never>()
    
    private var cancellables              = Set<AnyCancellable>()
    
    var startAnimation: Void {
       loadingView.isHidden = false
       loadingView.startAnimating()
    }
    
    var endAnimation: Void {
        loadingView.stopAnimating()
    }
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        configureLayoutUI()
        bindAction()
    }
    
    func setItemViews(with followerDetailInfo: FollowerDetailInformation) {
        headerView.configureContents(of: followerDetailInfo)
        itemOneView.configureContents(for: .followersAndFollowing,
                                      followerDetailInfo: followerDetailInfo)
        itemTwoView.configureContents(for: .reposAndGists,
                                      followerDetailInfo: followerDetailInfo)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Binding
extension FollowerDetailView {
    private func bindAction() {
        addToFavoriteButton.tapPublisher
            .sink(receiveValue: { [unowned self] in
                self.actionSubject.send(.add)
            }).store(in: &cancellables)
        
        doneButton.tapPublisher
            .sink { [unowned self] in
                self.actionSubject.send(.done)
            }.store(in: &cancellables)
        
        itemOneView.button.tapPublisher
            .sink { [unowned self] in
                self.actionSubject.send(.getFollowers)
            }.store(in: &cancellables)
        
        itemTwoView.button.tapPublisher
            .sink { [unowned self] in
                self.actionSubject.send(.gitHubProfile)
            }.store(in: &cancellables)
    }
}

//MARK: - configure UI
extension FollowerDetailView {
    private func configureLayoutUI() {
        
        [headerView, itemOneView, itemTwoView, loadingView]
            .forEach {[unowned self] in
                self.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
        
        let paddingBetweenItemViews: CGFloat = 20
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            itemOneView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: paddingBetweenItemViews),
            itemOneView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: paddingBetweenItemViews),
            itemOneView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -paddingBetweenItemViews),
            itemOneView.heightAnchor.constraint(equalToConstant: 140),
            
            itemTwoView.topAnchor.constraint(equalTo: itemOneView.bottomAnchor, constant: paddingBetweenItemViews),
            itemTwoView.leadingAnchor.constraint(equalTo: itemOneView.leadingAnchor),
            itemTwoView.trailingAnchor.constraint(equalTo: itemOneView.trailingAnchor),
            itemTwoView.heightAnchor.constraint(equalToConstant: 140),
            
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingView.heightAnchor.constraint(equalToConstant: 50),
            loadingView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
