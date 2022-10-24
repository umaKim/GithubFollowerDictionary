//
//  FollowerDetailHeaderView.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/29.
//
import Combine
import UIKit

final class FollowerDetailHeaderView: UIView {

    private let avatarImageView     = IGImageView()
    private let usernameLabel       = IGTitleLabel()
    private let nameLabel           = IGSecondaryTitleLabel(fontSize: 18)
    private let locationImageView   = UIImageView()
    private let locationNameLabel   = IGSecondaryTitleLabel(fontSize: 15)
    private let bioLabel            = IGBodyLabel(textAlignment: .left)
    
    private var cancellables        = Set<AnyCancellable>()
    
    init() {
        super.init(frame: .zero)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViewController() {
        backgroundColor = .cyan
    }
    
    private var subscription = Set<AnyCancellable>()
    
    private let network = NetworkService()
    
    func configureContents(of followerDetailInfo: FollowerDetailInformation) {
        ProfileImageLoader.shared.loadImage(from: followerDetailInfo.avatarUrl)
            .receive(on: RunLoop.main)
            .replaceError(with: UIImage())
            .sink(receiveValue: { image in
                self.avatarImageView.image = image
            })
            .store(in: &cancellables)

        
        usernameLabel.text          = followerDetailInfo.login
        nameLabel.text              = followerDetailInfo.name ?? "N/A"
        locationImageView.image     = UIImage(systemName: "mappin.and.ellipse")
        locationNameLabel.text      = followerDetailInfo.location ?? "No Location"
        bioLabel.text               = followerDetailInfo.bio
    }
}

final class FollowerDetailHeaderViewModel {
    private(set) var followerDetailInfo: FollowerDetailInformation
    private let network: NetworkServiceProtocol
    
    init(followerDetailInfo: FollowerDetailInformation,
        network: NetworkServiceProtocol) {
        self.followerDetailInfo = followerDetailInfo
        self.network = network
        
    }
}

//MARK: - Configure UI
extension FollowerDetailHeaderView {
    private func configureViews() {
        let views = [avatarImageView, usernameLabel, nameLabel, locationImageView, locationNameLabel, bioLabel]
        
        views.forEach { view in
            self.addSubview(view)
        }
        
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: textImagePadding),
            locationImageView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationNameLabel.topAnchor.constraint(equalTo: locationImageView.topAnchor),
            locationNameLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: textImagePadding),
            locationNameLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            locationNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: locationNameLabel.bottomAnchor),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: locationNameLabel.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
