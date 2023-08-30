//
//  FinancialAdministratorMainView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 14/08/23.
//

import UIKit

protocol FinancialAdministratorMainViewDelegate: AnyObject {
    func handleTitleAndDescriptionCardViewTap(model: FinancialAdministratorActions)
}

final class FinancialAdministratorMainView: UIView {
    
    weak var delegate: FinancialAdministratorMainViewDelegate?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.isAccessibilityElement = false
        
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(
            top: 16,
            left: 16,
            bottom: 16,
            right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        
        return stackView
    }()
    
    private lazy var hideAndShowBalanceView: HideAndShowBalanceView = {
        let hideAndShowBalanceView = HideAndShowBalanceView()
        hideAndShowBalanceView.translatesAutoresizingMaskIntoConstraints = false
        
        return hideAndShowBalanceView
    }()
    
    init(){
        super.init(frame: .zero)
        setupView()
        setupConstraints()
        backgroundColor = .white
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(with model: FinancialAdministratorMainViewModel){
        hideAndShowBalanceView.updateView(
            username: model.username,
            balance: model.balance)
        
        for i in (1...model.items.count) {
            let card = TitleAndDescriptionCardView()
            card.updateView(model: model.items[i-1])
            card.updateAccessibility(
                model: model.items[i-1],
                currentIndex: i,
                total: model.items.count)
            card.delegate = self
            card.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(card)
            card.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
            card.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        }
    }
    
    private func setupView(){
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(hideAndShowBalanceView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            hideAndShowBalanceView.leadingAnchor.constraint(equalTo: leadingAnchor),
            hideAndShowBalanceView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}

extension FinancialAdministratorMainView: TitleAndDescriptionCardViewDelegate {
    
    func handleTitleAndDescriptionCardViewTap(model: FinancialAdministratorActions) {
        delegate?.handleTitleAndDescriptionCardViewTap(model: model)
    }
    
}
