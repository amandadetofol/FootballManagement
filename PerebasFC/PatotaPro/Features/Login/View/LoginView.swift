//
//  LoginView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 15/05/23.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func goToLogin(
        username: String,
        password: String,
        teamId: String)
    func goToNewMemeberMessageView()
    func goToForgotPassword(username: String)
}

final class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    
    var showUsernameError: Bool = false {
        didSet {
            usernameTextField.showError = showUsernameError
        }
    }
    
    var showTeamIdError: Bool = false {
        didSet {
            teamIdTextField.showError = showTeamIdError
        }
    }
    
    var showInvalidEmailError: Bool = false {
        didSet {
            usernameTextField.showError = showUsernameError
            usernameTextField.errorMessage = "E-mail inválido."
        }
    }
    
    var showPasswordError: Bool = false {
        didSet {
            passwordTextField.showError = showPasswordError
        }
    }
    
    private lazy var usernameTextField: TextFieldComponent = {
        let textfield = TextFieldComponent()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.title = "E-mail"
        
        return textfield
    }()
    
    private lazy var passwordTextField: TextFieldComponent = {
        let textfield = TextFieldComponent()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.isSafeTextField = true
        textfield.title = "Senha"
        textfield.showEyeButton()
        
        return textfield
    }()
    
    private lazy var teamIdTextField: TextFieldComponent = {
        let textfield = TextFieldComponent()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.title = "ID do time"
        
        return textfield
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitle("Entrar".uppercased(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
     
        return button
    }()
    
    private lazy var notSignedButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitle("Não tenho cadastro", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(goToNewMemeberMessageView), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitle("Esqueci minha senha", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(goToForgotPassword), for: .touchUpInside)
        
        return button
    }()
    
    init(){
        super.init(frame: .zero)
        setupView()
        setupConstraints()
        updateViewWithSavedCode()
        self.backgroundColor = .systemBackground
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateViewWithSavedCode(){
        if let code = UserDefaults.standard.string(forKey: "recentTeamCode") {
            teamIdTextField.text = code
        }
    }
    
    private func setupView(){
        addSubviews(
            [usernameTextField,
             passwordTextField,
             teamIdTextField,
             loginButton,
             notSignedButton,
             forgotPasswordButton])
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 168),
            usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
           
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            teamIdTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8),
            teamIdTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            teamIdTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            loginButton.topAnchor.constraint(equalTo: teamIdTextField.bottomAnchor, constant: 32),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            
            notSignedButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            notSignedButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            notSignedButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            notSignedButton.heightAnchor.constraint(equalToConstant: 48),
            
            forgotPasswordButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -48),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
}

extension LoginView {
    
    @objc func login(){
        usernameTextField.showError = false
        teamIdTextField.showError = false
        passwordTextField.showError = false 
        
        delegate?.goToLogin(
            username: usernameTextField.text,
            password: passwordTextField.text,
            teamId: teamIdTextField.text)
    }
    
    @objc func goToNewMemeberMessageView(){
        delegate?.goToNewMemeberMessageView()
    }
    
    @objc func goToForgotPassword(){
        delegate?.goToForgotPassword(username: usernameTextField.text)
    }
    
}
