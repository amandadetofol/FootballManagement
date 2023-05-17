//
//  ErrorComponentView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 16/05/23.
//

import UIKit

protocol ErrorComponentViewDelegate: AnyObject {
    func handleFirstActionButtonTap()
    func handleSecondActionButtonTap()
}

final class ErrorComponentView: UIView {
    
    weak var delegate: ErrorComponentViewDelegate?
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20.0)
        
        return label
    }()
    
    private lazy var firstActionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = .systemRed.withAlphaComponent(0.8)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleFirstActionButtonTap), for: .touchUpInside)
     
        return button
    }()
    
    private lazy var secondActionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action: #selector(handleSecondActionButtonTap), for: .touchUpInside)
     
        return button
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
    
    func updateView(with model: ErrorComponentViewModel) {
        descriptionLabel.text = model.description
        descriptionLabel.accessibilityLabel = model.descriptionAccessibility
        firstActionButton.setTitle(model.firstActionName, for: .normal)
        firstActionButton.accessibilityLabel = model.firstActionNameAccessibiliyDescription
        secondActionButton.setTitle(model.secondActionName, for: .normal)
        secondActionButton.accessibilityLabel = model.secondActionNameAccessibilityDesctiption
    }
    
    private func setupView( ){
        addSubviews(
            [descriptionLabel,
             firstActionButton,
             secondActionButton])
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 156),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        
            firstActionButton.bottomAnchor.constraint(equalTo: secondActionButton.topAnchor, constant: -8),
            firstActionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            firstActionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            firstActionButton.heightAnchor.constraint(equalToConstant: 48),
            
            secondActionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            secondActionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            secondActionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            secondActionButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}

extension ErrorComponentView {
    
    @objc func handleFirstActionButtonTap(){
        delegate?.handleFirstActionButtonTap()
    }
    
    @objc func handleSecondActionButtonTap(){
        delegate?.handleSecondActionButtonTap()
    }
    
}
