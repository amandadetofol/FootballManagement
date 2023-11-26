//
//  DeleteTeamView.swift
//  PatotaPro
//
//  Created by Amanda Detofol on 26/11/23.
//

import UIKit

protocol DeleteTeamViewDelegate: AnyObject {
    func handleConfirmButtonTap(id: String)
}

final class DeleteTeamView: UIView {
    
    weak var delegate: DeleteTeamViewDelegate?
    
    var idTextFieldHasError: Bool = false {
        didSet {
            idTextField.showError = idTextFieldHasError
        }
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
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
    
    private lazy var deleteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
       
        return label
    }()
    
    private lazy var idTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleConfirmButtonTap), for: .touchUpInside)
        
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
    
    func updateView(with model: DeleteTeamViewModel){
        idTextField.title = model.title
        deleteLabel.text = model.message
        confirmButton.setTitle(model.buttonTitle, for: .normal)
    }
    
    private func setupView(){
        backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubviews([
            deleteLabel,
            idTextField,
            confirmButton
        ])
        contentStackView.setCustomSpacing(120, after: idTextField)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            deleteLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 16),
            deleteLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            idTextField.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            idTextField.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            
            confirmButton.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 16),
            confirmButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            confirmButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
}

extension DeleteTeamView {
    
    @objc func handleConfirmButtonTap(){
        idTextField.showError = false 
        
        delegate?.handleConfirmButtonTap(
            id: idTextField.text)
    }
    
}
