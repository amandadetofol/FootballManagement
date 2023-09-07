//
//  PresenceView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/09/23.
//

import UIKit

protocol PresenceViewDelegate: AnyObject {
    func handleConfirmButtonTap()
}

final class PresenceView: UIView {
    
    weak var delegate: PresenceViewDelegate?
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isAccessibilityElement = false
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isAccessibilityElement = false
        
        return scrollView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        
        return stackView
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("confirmar".uppercased(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.addTarget(nil, action: #selector(handleConfirmButtonTap), for: .touchUpInside)
        
        return button
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
    
    func setupView(with model: [PresenceCardViewModel]){
        model.enumerated().forEach { (index, card) in
            var cardModel = card
            cardModel.currentIndex = index
            cardModel.total = model.count
            
            let card = PresenceCardView()
            card.updateAccessibility(with: cardModel)
            card.updateView(with: cardModel)
            contentStackView.addArrangedSubview(card)
        }
        setupConfirmButton()
    }
    
    private func setupConfirmButton(){
        contentStackView.addArrangedSubview(confirmButton)
        NSLayoutConstraint.activate([
            confirmButton.heightAnchor.constraint(equalToConstant: 48),
            confirmButton.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 16),
            confirmButton.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupView(){
        addSubview(contentView)
        contentView.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
}

extension PresenceView {
    
    @objc func handleConfirmButtonTap(){
        delegate?.handleConfirmButtonTap()
    }
    
}
