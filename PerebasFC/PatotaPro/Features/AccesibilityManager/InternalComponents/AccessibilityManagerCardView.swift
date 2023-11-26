//
//  AccessibilityManagerCardView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 01/09/23.
//

import UIKit

protocol AccessibilityManagerCardViewDelegate: AnyObject {
    func didTapButton()
}

final class AccessibilityManagerCardView: UIControl {
    
    weak var delegate: AccessibilityManagerCardViewDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var switchView: UISwitch = {
        let switchView = UISwitch()
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.isUserInteractionEnabled = false
        
        return switchView
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
    
    func updateView(model: AccessibilityManagerViewModel) {
        titleLabel.text = model.title
        switchView.isOn = model.isActive
    }
    
    func setupAccessibility(model: AccessibilityManagerViewModel) {
        self.isAccessibilityElement = true
        self.accessibilityTraits = .button
        self.accessibilityLabel = "\(model.title) \((model.isActive ? "ligado" : "desligado")). Ir para configurações de acessibilidade. Item \(model.currentIndex ?? 0) de \(model.total ?? 0)"
    }
    
    private func setupView(){
        addSubviews([
            titleLabel,
            switchView])
        backgroundColor = Session.shared.highLightColor.withAlphaComponent(0.50)
        addTarget(nil, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 48),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            switchView.centerYAnchor.constraint(equalTo: centerYAnchor),
            switchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
}

extension AccessibilityManagerCardView {
    
    @objc func didTapButton() {
        delegate?.didTapButton()
    }
    
}
