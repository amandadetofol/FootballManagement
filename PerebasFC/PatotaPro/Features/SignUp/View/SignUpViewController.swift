//
//  SignUpViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 11/09/23.
//

import UIKit

protocol SignUpInteractorProtocol {
    func handleCreateNewUserButtonTap(user: NewUserModel)
}

final class SignUpViewController: UIViewController {
    
    private lazy var signUpView: SignUpView = {
        let signUpView = SignUpView()
        signUpView.delegate = self
        
        return signUpView
    }()
    
    private let interactor: SignUpInteractorProtocol
 
    init(interactor: SignUpInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = signUpView
        title = "Cadastre-se"
        self.navigationController?.navigationBar.isHidden = false
        handleKeyBoardRemoveWhenClickOutsideField()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.signUpView.scrollView.frame.origin.y >= 0 {
                self.signUpView.scrollView.frame.origin.y -= keyboardSize.height/2 + 48
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.signUpView.scrollView.frame.origin.y = 0
    }
    
}

extension SignUpViewController: SignUpViewDelegate {
    
    func handleCreateNewUserButtonTap(user: NewUserModel) {
        interactor.handleCreateNewUserButtonTap(user: user)
    }
   
}

extension SignUpViewController: SignUpViewProtocol {
    
    func setupViewForInvalidEmailErrorState(){
        signUpView.showInvalidEmailError = true 
    }
    
    func setupViewForEmptyEmailErrorState() {
        signUpView.showEmailError = true
    }
    
    func setupViewForEmptyPasswordFieldState() {
        signUpView.showPasswordTextFieldError = true
    }
    
    func setupViewForEmptyConfirmPasswordFieldState() {
        signUpView.showPasswordConfirmationTextFieldError = true
    }
    
    func setupViewForMismatchingPasswordsErrorState() {
        signUpView.showMismatchingPasswordError = true 
    }
    
    func setupViewForTeamIdError(){
        signUpView.showIdError = true 
    }
    
}
