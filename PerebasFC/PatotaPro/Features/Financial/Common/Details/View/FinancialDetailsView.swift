//
//  FinancialDetailsView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 13/06/23.
//

import UIKit

protocol FinancialDetailsViewDelegate: AnyObject {
    func handleAddProofButtonTap()
}

final class FinancialDetailsView: UIView {
    
    weak var delegate: FinancialDetailsViewDelegate?
    var index: Int? 
    
    lazy var scrollView: UIScrollView = {
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
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: -16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        
        return stackView
    }()
    
    private lazy var informativeTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18.0)
        
        return label
    }()
    
    private lazy var disclaimerView: PendenciesDisclaimerView = {
        let view = PendenciesDisclaimerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBrown.withAlphaComponent(0.10)
        
        return view
    }()
    
    private lazy var addProofButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleAddProofButtonTap), for: .touchUpInside)
        
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
    
    func updateView(with model: FinancialDetailsViewModel){
        informativeTextLabel.text = model.informativeText
        disclaimerView.updateView(with: model.disclaimer)
        addProofButton.setTitle(model.actionTitle, for: .normal)
        self.index = model.index
    }
    
    private func setupView(){
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubviews([
            informativeTextLabel,
            disclaimerView,
            addProofButton])
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            informativeTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            informativeTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            disclaimerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            disclaimerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            addProofButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            addProofButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            addProofButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }

}

extension FinancialDetailsView {
    
    @objc func handleAddProofButtonTap(){
        delegate?.handleAddProofButtonTap()
    }
    
}
