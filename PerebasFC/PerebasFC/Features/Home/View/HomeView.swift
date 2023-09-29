//
//  HomeView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 22/05/23.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func handleLogout()
    func handleAccessibilityButtonTap()
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
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 0, bottom: -16, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true 
        
        return stackView
    }()
    
    private lazy var styleLeadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        
        return view
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
        
        viewModel.menuCards?.forEach { menuItem in
            let menuCard = MenuItemView()
            menuCard.updateView(with: menuItem)
            menuCard.delegate = self
            menuStackView.addArrangedSubview(menuCard)
        }
    
    }
    
    private func setupView(){
        self.addSubviews(
            [headerView,
             styleLeadingView,
             scrollView])
        scrollView.addSubview(contentView)
        contentView.addSubview(menuStackView)
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
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            menuStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            menuStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            menuStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            menuStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            menuStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
}

extension HomeView: MenuItemViewDelegate {
    
    func handleMenuItemViewTap(basedOn key: InternalLinkRedirectKeys) {
        delegate?.handleInternalLinkRedirect(key: key)
    }
    
}

extension HomeView: HomeHeaderViewDelegate {
    
    func handleAccessibilityButtonTap() {
        delegate?.handleAccessibilityButtonTap()
    }
    
    func handleLogout() {
        delegate?.handleLogout()
    }
    
}
