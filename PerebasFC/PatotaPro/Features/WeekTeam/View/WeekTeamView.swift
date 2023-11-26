//
//  WeekTeamView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 28/05/23.
//

import UIKit

final class WeekTeamView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.isAccessibilityElement = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .clear
        contentView.isAccessibilityElement = false
        
        return contentView
    }()
    
    private lazy var itemsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 16
        
        return stackView
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
    
    func setupView(with model: [WeekTeamListViewModel]){
        model.enumerated().forEach { (index, viewModel) in
            let card = WeekTeamListItemView()
            var cardModel = viewModel
            cardModel.currentIndex = index + 1
            cardModel.total = model.count
            
            card.setupCard(with: cardModel)
            card.updateAccessibility(model: cardModel)
            
            itemsStackView.addArrangedSubview(card)
            
            card.translatesAutoresizingMaskIntoConstraints = false
            card.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
            card.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
            
        }
    }
    
    func removeAllCards(){
        self.itemsStackView.arrangedSubviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
    
    private func setupView(){
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(itemsStackView)
        backgroundColor = .white
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
        
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            itemsStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            itemsStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
    
}
