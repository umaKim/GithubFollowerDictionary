//
//  File.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/24.
//
import Combine
import UIKit

final class FollowerListCell: UICollectionViewCell {
    static let identifier = "FollowerListCell"
    
    //MARK: - UI Objects
    lazy var profileImageView    = IGImageView()
    lazy var nameLabel           = IGLabel(textAlignment: .center, fontSize: 16)
    
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - ViewModel
    var viewModel: FollowerListCellViewModel? {
        didSet { setData }
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    private var setData: Void {
        viewModel?.imagePublisher
            .receive(on: RunLoop.main)
            .compactMap({$0})
            .assign(to: \.image, on: profileImageView)
            .store(in: &cancellables)
        
        viewModel?.$follower
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in
                self?.nameLabel.text = $0.login
            })
            .store(in: &cancellables)
    }
    
    //MARK: - Configure UI
    private func configureUI() {
        [profileImageView, nameLabel].forEach { view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
