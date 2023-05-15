//
//  LoginView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 15/05/23.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func goToLogin(username: String, password: String)
    func goToNewMemeberMessageView()
    func goToForgotPassword(username: String)
}

final class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName:"sportscourt.circle.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var usernameTextField: TextFieldComponent = {
        let textfield = TextFieldComponent()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        return textfield
    }()
    
    private lazy var passwordTextField: TextFieldComponent = {
        let textfield = TextFieldComponent()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.isSafeTextField = true 
        
        return textfield
    }()
    
}
