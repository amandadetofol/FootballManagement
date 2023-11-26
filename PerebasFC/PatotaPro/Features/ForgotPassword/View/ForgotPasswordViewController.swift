//
//  ForgotPasswordViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 22/05/23.
//

import UIKit

protocol ForgotPasswordInteractorProtocol {
    func viewDidLoad()
    func recoverPassword(email: String)
}

final class ForgotPasswordViewController: UIViewController {
    
    private lazy var forgotPasswordView: ForgotPasswordView = {
        let view = ForgotPasswordView()
        view.delegate = self
        
        return view
    }()
    
    private let interactor: ForgotPasswordInteractorProtocol
    
    init(interactor: ForgotPasswordInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = forgotPasswordView
        
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Esqueceu sua senha?"
        interactor.viewDidLoad()
        handleKeyBoardRemoveWhenClickOutsideField()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ForgotPasswordViewController: ForgotPasswordViewProtocol {
   
    func updateEmailTextfieldContent(with email: String) {
        forgotPasswordView.email = email
    }
    
    func updateEmailTextfieldForError(using message: String) {
        forgotPasswordView.errorMessage = message
    }

}

extension ForgotPasswordViewController: ForgotPasswordViewDelegate {
    
    func recoverPassword(email: String) {
        interactor.recoverPassword(email: email)
    }
    
}
