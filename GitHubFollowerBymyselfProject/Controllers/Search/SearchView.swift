//
//  SearchView.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/08.
//
import CombineCocoa
import Combine
import UIKit

enum SearchViewAction: Transition {
    case searchDidTap
    case searchQuery(String)
}

final class SearchView: UIView {
    //MARK: - UI Objects
    private lazy var appLogoImageView    = UIImageView()
    private lazy var getFollowersButton  = IGButton(backgroundColor: .systemBlue,
                                                    title: Constants.Text.getFollowers)
    private lazy var usernameTextField   = IGTextField()
    
    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject = PassthroughSubject<SearchViewAction, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .systemBackground
        
        addTapGestureToViewForKeyboardDismiss()
        
        configureAppTitleImage()
        configureTextField()
        configureButton()
        bindAction()
    }
    
    func setGetFollowersButton(_ isValid: Bool) {
        getFollowersButton.isEnabled = isValid
        getFollowersButton.backgroundColor = isValid ? .systemBlue : .systemGray4
    }
    
    private func addTapGestureToViewForKeyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Binding
extension SearchView {
    private func bindAction() {
        getFollowersButton
            .tapPublisher
            .sink { [unowned self] in
                self.actionSubject.send(.searchDidTap)
            }
            .store(in: &cancellables)
        
        usernameTextField
            .textPublisher
            .compactMap({$0})
            .sink { [unowned self] in
                self.actionSubject.send(.searchQuery($0))
            }
            .store(in: &cancellables)
    }
}

//MARK: - Configure UI
extension SearchView {
    private func configureAppTitleImage() {
        addSubview(appLogoImageView)
        
        appLogoImageView.image = UIImage(named: Constants.Image.gitHubTitle)
        appLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageSideLength: CGFloat = 200
        
        NSLayoutConstraint.activate([
            appLogoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            appLogoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            appLogoImageView.heightAnchor.constraint(equalToConstant: imageSideLength / 2),
            appLogoImageView.widthAnchor.constraint(equalToConstant: imageSideLength)
        ])
    }
    
    private func configureTextField() {
        addSubview(usernameTextField)
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: appLogoImageView.bottomAnchor, constant: 50),
            usernameTextField.centerXAnchor.constraint(equalTo: appLogoImageView.centerXAnchor),
            usernameTextField.widthAnchor.constraint(equalToConstant: 250),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureButton() {
        addSubview(getFollowersButton)
        
        let buttonWidth: CGFloat = 200
        let buttonHeight: CGFloat = 70
        
        NSLayoutConstraint.activate([
            getFollowersButton.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 100),
            getFollowersButton.centerXAnchor.constraint(equalTo: usernameTextField.centerXAnchor),
            getFollowersButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            getFollowersButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
}
