//
//  HomeView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 22/05/23.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func handleAlertCloseButtonTap()
    func handleAlertActionButtonTap(key: InternalLinkRedirectKeys)
}

final class HomeView: UIView {
    
    weak var delegate: HomeViewDelegate?
    
    private lazy var headerView: HomeHeaderView = {
        let headerView = HomeHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.updateView(with: HomeHeaderViewModel(welcomeText: "Olá!", initials: "UT", fullName: "Usuário de Teste"))
        
        return headerView
    }()
    
    //TODO: COLOCAR O NEGÓCIO PRA VER O TIME AQ
    
    private lazy var menuStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var styleLeadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed.withAlphaComponent(0.3)
        
        return view
    }()
    
    private lazy var userAlertView: UserAlertWarningView = {
        let userAlertView = UserAlertWarningView()
        userAlertView.translatesAutoresizingMaskIntoConstraints = false
        userAlertView.delegate = self
        userAlertView.isHidden = true
        
        return userAlertView
    }()
    
    
    init(){
        super.init(frame: .zero)
        self.backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        self.addSubviews(
            [headerView,
             styleLeadingView,
             menuStackView,
             userAlertView])
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            styleLeadingView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            styleLeadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            styleLeadingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            styleLeadingView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/4),
            
            menuStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            menuStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuStackView.widthAnchor.constraint(equalTo: widthAnchor),
            menuStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            userAlertView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -48),
            userAlertView.leadingAnchor.constraint(equalTo: leadingAnchor),
            userAlertView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
}

extension HomeView: UserAlertWarningViewDelegate {
    
    func handleCloseButtonTap() {
        delegate?.handleAlertCloseButtonTap()
    }
    
    func handleActionButtonTap(key: InternalLinkRedirectKeys) {
        delegate?.handleAlertActionButtonTap(key: key)
    }
    
}
