//
//  ChangePasswordView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/06/23.
//

import UIKit

protocol ChangePasswordViewDelegate: AnyObject {
    func handleConfirmPasswordChangeButtonTap(changePasswordModel: ChangePasswordModel)
}

final class ChangePasswordView: UIView {
    
    weak var delegate: ChangePasswordViewDelegate?
    
    var shouldShowNewPasswordTextFieldError: Bool = false {
        didSet {
            newPasswordTextField.showError = shouldShowNewPasswordTextFieldError
        }
    }
    
    var shouldShowNewPasswordConfirmTextFieldError: Bool = false {
        didSet {
            confirmNewPasswordTextField.showError = shouldShowNewPasswordConfirmTextFieldError
        }
    }
    
    var shouldShowPasswordsMismatchingError: Bool = false {
        didSet {
            confirmNewPasswordTextField.errorMessage = "As senhas não conferem."
            confirmNewPasswordTextField.showError = true
        }
    }
    
    private lazy var newPasswordTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.title = "Nova senha"
        textField.showEyeButton()
        textField.isSafeTextField = true
        
        return textField
    }()
    
    private lazy var confirmNewPasswordTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.title = "Repita a nova senha"
        textField.showEyeButton()
        textField.isSafeTextField = true
        
        return textField
    }()
    
    private lazy var confirmPasswordChangeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitle("confirmar".uppercased(), for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(confirmPasswordChangeButtonTap), for: .touchUpInside)
        
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
        self.addSubviews([
            newPasswordTextField,
            confirmNewPasswordTextField,
            confirmPasswordChangeButton])
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            newPasswordTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            newPasswordTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            newPasswordTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            confirmNewPasswordTextField.topAnchor.constraint(equalTo: newPasswordTextField.bottomAnchor, constant: 32),
            confirmNewPasswordTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            confirmNewPasswordTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            confirmPasswordChangeButton.heightAnchor.constraint(equalToConstant: 48),
            confirmPasswordChangeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            confirmPasswordChangeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            confirmPasswordChangeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
        ])
    }
}

extension ChangePasswordView {
    
    @objc func confirmPasswordChangeButtonTap(){
        confirmNewPasswordTextField.showError = false
        newPasswordTextField.showError = false 
        
        delegate?.handleConfirmPasswordChangeButtonTap(
            changePasswordModel: ChangePasswordModel(
                newPassword: newPasswordTextField.text,
                newPasswordRepetead: confirmNewPasswordTextField.text))
    }
    
}
