//
//  ForgotPasswordView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 22/05/23.
//

import UIKit

protocol ForgotPasswordViewDelegate: AnyObject {
    func recoverPassword(email: String)
}

final class ForgotPasswordView: UIView {
    
    weak var delegate: ForgotPasswordViewDelegate?
    
    var errorMessage: String = ""{
        didSet {
            emailTextfield.showError = true
            emailTextfield.errorMessage = "Campo obrigatório"
        }
    }
    
    var email: String = "" {
        didSet {
            emailTextfield.text = email
        }
    }
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "Para recuperar sua senha, preencha o campo abaixo com o seu e-mail. Enviaremos um link onde poderá ser feita a troca de senha."
        label.font = UIFont.systemFont(ofSize: 20.0)
        
        return label
    }()
    
    private lazy var emailTextfield: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "E-mail"
        
        return textField
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitle("recuperar senha".uppercased(), for: .normal)
        button.backgroundColor = .systemRed.withAlphaComponent(0.8)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(recoverPassword), for: .touchUpInside)
        
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
    
    private func setupView(){
        self.backgroundColor = .systemBackground
        self.addSubviews([messageLabel, emailTextfield, continueButton])
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 108),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            emailTextfield.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            emailTextfield.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            emailTextfield.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            continueButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32),
            continueButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            continueButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}

extension ForgotPasswordView {
    
    @objc func recoverPassword(){
        delegate?.recoverPassword(email: emailTextfield.text)
    }
    
}
