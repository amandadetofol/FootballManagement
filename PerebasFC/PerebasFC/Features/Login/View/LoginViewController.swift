//
//  LoginViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 16/05/23.
//

import UIKit

protocol LoginInteractorProtocol {
    func goToLogin(_ username: String, _ password: String)
    func goToNewMemeberMessageView()
    func loginWithGoogle(controller: UIViewController)
    func goToForgotPassword(_ username: String)
}

final class LoginViewController: UIViewController {
    
    private lazy var loginView: LoginView = {
        let loginView = LoginView()
        loginView.delegate = self
        
        return loginView
    }()
    
    private let interactor: LoginInteractorProtocol
    
    init(interactor: LoginInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        title = "Login"
        handleKeyBoardRemoveWhenClickOutsideField()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
}

extension LoginViewController: LoginViewProtocol {
    
    func updateViewForMandatoryUsernameError() {
        loginView.showUsernameError = true
    }
    
    func updateViewForMandatoryPasswordError() {
        loginView.showPasswordError = true
    }
    
}

extension LoginViewController: LoginViewDelegate {
    
    func goToLogin(username: String, password: String) {
        interactor.goToLogin(username, password)
    }
    
    func goToNewMemeberMessageView() {
        interactor.goToNewMemeberMessageView()
    }
    
    func goToForgotPassword(username: String) {
        interactor.goToForgotPassword(username)
    }
    
    func loginWithGoogle(){
        interactor.loginWithGoogle(controller: self)
    }
    
}
