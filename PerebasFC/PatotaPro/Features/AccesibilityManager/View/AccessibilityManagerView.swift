//
//  AccessibilityManagerView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 13/08/23.
//

import UIKit

protocol AccessibilityManagerViewDelegate: AnyObject {
    func didTapButton()
}

final class AccessibilityManagerView: UIView {
    
    weak var delegate: AccessibilityManagerViewDelegate?
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.backgroundColor = .white
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Ajustes de acessibilidade"
        
        return label
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
    
    func updateView(accessibilityOptions: [AccessibilityManagerViewModel]){
        accessibilityOptions.enumerated().forEach { [weak self] (index, option) in
            guard let self else { return }
            
            var model = option
            model.total = accessibilityOptions.count
            model.currentIndex = index + 1
            
            let card = AccessibilityManagerCardView()
            card.updateView(model: model)
            card.setupAccessibility(model: model)
            card.delegate = self 
            
            contentStackView.addArrangedSubview(card)
        }
    }
    
    private func setupView(){
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        backgroundColor = .silver.withAlphaComponent(0.50)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: widthAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
        ])
    }
}

extension AccessibilityManagerView: AccessibilityManagerCardViewDelegate {
    
    func didTapButton(){
        delegate?.didTapButton()
    }
    
}
