//
//  SignUpView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 11/09/23.
//

import UIKit

protocol SignUpViewDelegate: AnyObject {
    func handleCreateNewUserButtonTap(user: NewUserModel)
}

final class SignUpView: UIView {
    
    var showEmailError: Bool = false {
        didSet {
            emailTextField.showError = showEmailError
        }
    }
    
    var showIdError: Bool = false {
        didSet {
            teamIdTextField.showError = showIdError
        }
    }
    
    var showInvalidEmailError: Bool = false {
        didSet {
            emailTextField.showError = true
            emailTextField.errorMessage = "E-mail inválido."
        }
    }
    
    var showPasswordTextFieldError: Bool = false {
        didSet {
            passwordTextField.showError = showPasswordTextFieldError
        }
    }
    
    var showPasswordConfirmationTextFieldError: Bool = false {
        didSet {
            passwordConfirmTextField.showError = showPasswordConfirmationTextFieldError
        }
    }
    
    var showMismatchingPasswordError: Bool = false {
        didSet {
            passwordConfirmTextField.showError = true
            passwordConfirmTextField.errorMessage = "As senhas não são iguais."
        }
    }
    
    weak var delegate: SignUpViewDelegate?
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isAccessibilityElement = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
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
    
    private lazy var emailTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.title = "E-mail"
        
        return textField
    }()
    
    private lazy var passwordTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.title = "Senha"
        textField.isSafeTextField = true
        textField.showEyeButton()
        
        return textField
    }()
    
    private lazy var passwordConfirmTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.title = "Confirme sua senha"
        textField.isSafeTextField = true
        textField.showEyeButton()
        
        return textField
    }()
    
    private lazy var teamIdTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.title = "ID do time"

        return textField
    }()
    
    private lazy var isAdmLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Administrador"
        
        return label
    }()
    
    private lazy var createNewUserButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirmar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.addTarget(nil, action: #selector(handleCreateNewUserButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var isAdm: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        
        return mySwitch
    }()
    
    init(){
        super.init (frame: .zero)
        setupView()
        setupConstraints()
        backgroundColor = .white
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(contentView)
        contentView.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubviews([
            emailTextField,
            passwordTextField,
            passwordConfirmTextField,
            teamIdTextField,
            isAdmLabel,
            isAdm,
            createNewUserButton
        ])
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
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            emailTextField.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -16),
            
            passwordConfirmTextField.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 16),
            passwordConfirmTextField.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -16),
            
            passwordTextField.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -16),
            
            teamIdTextField.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 16),
            teamIdTextField.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -16),
            
            isAdmLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 32),
            isAdmLabel.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -24),
            
            isAdm.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 32),
            
            createNewUserButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            createNewUserButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            createNewUserButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
}

extension SignUpView {
    
    @objc func handleCreateNewUserButtonTap(){
        
        emailTextField.showError = false
        passwordTextField.showError = false
        passwordConfirmTextField.showError = false 
        
        delegate?.handleCreateNewUserButtonTap(
            user: NewUserModel(
                isAdm: isAdm.isOn,
                email: emailTextField.text,
                password: passwordTextField.text,
                confirmPassword: passwordConfirmTextField.text,
                teamId: teamIdTextField.text)
        )
    }
    
}
