//
//  FinancialPendenciesView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 12/06/23.
//

import UIKit

protocol FinancialPendenciesViewDelegate: AnyObject {
    func handleFinancialPendencieCardTap(model: FinancialPendencieCardViewModel)
}

final class FinancialPendenciesView: UIView {
    
    weak var delegate: FinancialPendenciesViewDelegate?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.isAccessibilityElement = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isAccessibilityElement = false
        
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(top: 32, left: 16, bottom: -16, right: -32)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        
        return stackView
    }()
    
    init(){
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(with model: [FinancialPendencieCardViewModel]){
        contentStackView.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
        
        model.forEach { cardModel in
            let card = FinancialPendencieCardView()
            card.updateView(with: cardModel)
            card.delegate = self
            card.translatesAutoresizingMaskIntoConstraints = false
            contentStackView.addArrangedSubview(card)
            
            card.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
            card.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        }
    }
        
    private func setupView(){
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
    
}

extension FinancialPendenciesView: FinancialPendencieCardViewDelegate {
    
    func handleFinancialPendencieCardTap(model: FinancialPendencieCardViewModel) {
        delegate?.handleFinancialPendencieCardTap(model: model)
    }
    
}
