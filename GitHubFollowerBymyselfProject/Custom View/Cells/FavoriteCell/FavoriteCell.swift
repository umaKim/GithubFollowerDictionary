//
//  FavoriteCell.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/30.
//
import Combine
import UIKit

final class FavoriteCell: UITableViewCell {
    static let identifier = "FavoriteCell"
    
    //MARK: - UI Objects
    private lazy var avatarImageView    = IGImageView()
    private lazy var usernameLabel      = IGTitleLabel(textAlignment: .left, fontSize: 20)
    
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - ViewModel
    var viewModel: FollowerListCellViewModel? {
        didSet{ setData }
    }
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUILayOut()
    }
    
    private var setData: Void {
        avatarImageView.downloaded(from: viewModel?.follower.avatar_url ?? "")
        
        viewModel?.$follower
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in
                self?.usernameLabel.text = $0.login
            })
            .store(in: &cancellables)
    }
    
    //MARK: - Configure UI
    private func configureUILayOut() {
        [avatarImageView, usernameLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let imageLength: CGFloat = 60
        let padding: CGFloat = 20

        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: imageLength),
            avatarImageView.widthAnchor.constraint(equalToConstant: imageLength),

            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

