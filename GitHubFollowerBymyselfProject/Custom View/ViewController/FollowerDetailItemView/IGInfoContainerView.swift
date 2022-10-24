//
//  GFReposGistsViewController.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/29.
//

import UIKit

enum DetailInfoType {
    case followersAndFollowing
    case reposAndGists
}

final class IGInfoContainerView: IGFollowerDetailItemView {

    //MARK: - Init
    override init() {
        super.init()
        configureViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Configure UI
extension IGInfoContainerView {
    private func configureViewController() {
        backgroundColor = .secondarySystemBackground
    }
    
    func configureContents(for type: DetailInfoType, followerDetailInfo: FollowerDetailInformation) {
        
        switch type {
        case .followersAndFollowing:
            itemOne.imageSymbol.image = UIImage(systemName: "folder")
            itemOne.titleLabel.text = "Following"
            itemOne.countLabel.text = "\(followerDetailInfo.followers)"
            
            itemTwo.imageSymbol.image = UIImage(systemName: "folder")
            itemTwo.titleLabel.text = "Followers"
            itemTwo.countLabel.text = "\(followerDetailInfo.following)"
            
            button.backgroundColor = .systemBlue
            button.setTitle("Get Followers", for: .normal)
            
        case .reposAndGists:
            itemOne.imageSymbol.image = UIImage(systemName: "folder")
            itemOne.titleLabel.text = "Public Gists"
            itemOne.countLabel.text = "\(followerDetailInfo.publicGists)"
            
            itemTwo.imageSymbol.image = UIImage(systemName: "folder")
            itemTwo.titleLabel.text = "Public Repos"
            itemTwo.countLabel.text = "\(followerDetailInfo.publicRepos)"
            
            button.backgroundColor = .systemBlue
            button.setTitle("Github Profile", for: .normal)
        }
    }
}
