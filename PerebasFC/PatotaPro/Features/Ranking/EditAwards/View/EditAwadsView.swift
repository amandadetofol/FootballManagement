//
//  EditAwadsView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 15/06/23.
//

import UIKit

protocol EditAwadsViewDelegate: AnyObject {
    func handleGoToBackButtonTap()
    func handleSetNewAwardsButtonTap(using model: FirstPlaceGiftsViewModel)
}

final class EditAwadsView: UIView {
    
    weak var delegate: EditAwadsViewDelegate?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.isAccessibilityElement = false
        scrollView.isScrollEnabled = true
        
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
        stackView.alignment = .bottom
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 0, bottom: -32, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        
        return stackView
    }()
    
    private lazy var firstAwardTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.title = "1° Prêmio"
        
        return textField
    }()
    
    private lazy var secondAwardTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.title = "2° Prêmio"
        
        return textField
    }()
    
    private lazy var thirdAwardTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.title = "3° Prêmio"
        
        return textField
    }()
    
    private lazy var setNewAwardsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.setTitle("Salvar", for: .normal)
        button.addTarget(self, action: #selector(handleSetNewAwardsButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.setTitle("Voltar", for: .normal)
        button.addTarget(self, action: #selector(handleBackButtonTap), for: .touchUpInside)
        
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
    
    func setupView(with model: EditAwardsViewModel) {
        firstAwardTextField.text = model.currentFirstAward
        secondAwardTextField.text = model.currentSecondAward
        thirdAwardTextField.text = model.currentThirdAward
    }
    
    private func setupView(){
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubviews([
            firstAwardTextField,
            secondAwardTextField,
            thirdAwardTextField,
            setNewAwardsButton,
            backButton])
        backgroundColor = .white
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
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
            
            firstAwardTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            firstAwardTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            secondAwardTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            secondAwardTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            thirdAwardTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            thirdAwardTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            setNewAwardsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            setNewAwardsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            setNewAwardsButton.heightAnchor.constraint(equalToConstant: 48),
            
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            backButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
}

extension EditAwadsView {
    
    @objc func handleSetNewAwardsButtonTap(){
        delegate?.handleSetNewAwardsButtonTap(using: FirstPlaceGiftsViewModel(
            first: firstAwardTextField.text,
            second: secondAwardTextField.text,
            third: thirdAwardTextField.text))
    }
    
    @objc func handleBackButtonTap(){
        delegate?.handleGoToBackButtonTap()
    }
    
}
