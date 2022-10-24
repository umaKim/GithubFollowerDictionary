//
//  AlertViewController.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/29.
//

import UIKit

//MARK: Name variables explicitly
//MARK: Dismiss should go through delegate pattern

class AlertViewController: UIViewController {

    let viewContainer   = UIView()
    let alertTitle      = IGTitleLabel(textAlignment: .center, fontSize: 20)
    let alertMessage    = IGBodyLabel(textAlignment: .center)
    let button          = IGButton(backgroundColor: .systemBlue, title: "Ok")
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        alertTitle.text      = title
        alertMessage.text    = message
        button.titleLabel?.text = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureViewContainer()
        configureTitle()
        configureMessage()
        configureButton()
    }
    
    private func configureViewController(){
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
    }

    private func configureViewContainer() {
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.backgroundColor = .systemBackground
        viewContainer.layer.cornerRadius = 10
        
        view.addSubview(viewContainer)
        
        NSLayoutConstraint.activate([
            viewContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            viewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewContainer.widthAnchor.constraint(equalToConstant: 200),
            viewContainer.heightAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    private func configureTitle() {
        view.addSubview(alertTitle)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            alertTitle.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: padding),
            alertTitle.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor)
        ])
        
    }
    
    private func configureMessage() {
        view.addSubview(alertMessage)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            alertMessage.topAnchor.constraint(equalTo: alertTitle.bottomAnchor, constant: padding),
            alertMessage.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            alertMessage.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            alertMessage.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor)
        ])
    }
    
    private func configureButton() {
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(dismissAlertViewController), for: .touchUpInside)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: alertMessage.bottomAnchor,constant: 10),
            button.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: padding),
            button.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -padding),
            button.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -padding),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func dismissAlertViewController() {
        dismiss(animated: true, completion: nil)
    }
}
