//
//  HomeView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 22/05/23.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func handleLogout()
    func handleAlertCloseButtonTap()
    func handleInternalLinkRedirect(key: InternalLinkRedirectKeys)
}

final class HomeView: UIView {
    
    weak var delegate: HomeViewDelegate?
    
    private lazy var headerView: HomeHeaderView = {
        let headerView = HomeHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.delegate = self
        
        return headerView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isAccessibilityElement = false
        scrollView.backgroundColor = .clear
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isAccessibilityElement = false
        
        return view
    }()
    
    private lazy var menuStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        
        return stackView
    }()
    
    private lazy var styleLeadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed.withAlphaComponent(0.3)
        
        return view
    }()
    
    private lazy var teamCardView: CurrentTeamCardView = {
        let currentTeamCardView = CurrentTeamCardView()
        currentTeamCardView.translatesAutoresizingMaskIntoConstraints = false
        currentTeamCardView.isHidden = false
        
        return currentTeamCardView
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
    
    func updateView(viewModel: HomeViewModel){
        headerView.updateView(with: viewModel.header)
       
        if let teamModel = viewModel.teamInfo {
            teamCardView.updateView(with: teamModel)
        }
        
        viewModel.menuCards.forEach { menuItem in
            let menuCard = MenuItemView()
            menuCard.updateView(with: menuItem)
            menuCard.delegate = self
            menuStackView.addArrangedSubview(menuCard)
        }
        
        if let alertModel = viewModel.warning {
            userAlertView.updateView(withModel: alertModel)
            UIView.animate(withDuration: 1) { [weak self] in
                self?.userAlertView.isHidden = false
            }
        }
    }
    
    private func setupView(){
        self.addSubviews(
            [headerView,
             styleLeadingView,
             scrollView,
             userAlertView])
        scrollView.addSubview(contentView)
        contentView.addSubview(menuStackView)
        menuStackView.addArrangedSubview(teamCardView)
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
            
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            menuStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            menuStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            menuStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            menuStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            menuStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
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
        delegate?.handleInternalLinkRedirect(key: key)
    }
    
}

extension HomeView: MenuItemViewDelegate {
    
    func handleMenuItemViewTap(basedOn key: InternalLinkRedirectKeys) {
        delegate?.handleInternalLinkRedirect(key: key)
    }
    
}

extension HomeView: HomeHeaderViewDelegate {
    
    func handleLogout() {
        delegate?.handleLogout()
    }
    
}
