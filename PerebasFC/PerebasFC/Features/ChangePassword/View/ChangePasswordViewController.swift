//
//  ChangePasswordViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/06/23.
//

import UIKit

protocol ChangePasswordInteractorProtocol {
    func handleConfirmPasswordChangeButtonTap(changePasswordModel: ChangePasswordModel)
}

final class ChangePasswordViewController: UIViewController {
    
    private lazy var changePasswordView: ChangePasswordView = {
        let view = ChangePasswordView()
        view.delegate = self
        
        return view
    }()
    
    private let interactor: ChangePasswordInteractorProtocol
    
    init(interactor: ChangePasswordInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = changePasswordView
        view.backgroundColor = .white
        
        self.title = "Alterar senha"
        self.navigationController?.isNavigationBarHidden = false
        handleKeyBoardRemoveWhenClickOutsideField()
    }
    
}

extension ChangePasswordViewController: ChangePasswordViewDelegate {
   
    func handleConfirmPasswordChangeButtonTap(changePasswordModel: ChangePasswordModel) {
            interactor.handleConfirmPasswordChangeButtonTap(changePasswordModel: changePasswordModel)
    }
    
}

extension ChangePasswordViewController: ChangePasswordViewProtocol {
    
    func updateNewPasswordTextFieldForErrorState() {
        changePasswordView.shouldShowNewPasswordTextFieldError = true
    }
    
    func updateConfirmNewPasswordTextFieldForErrorState() {
        changePasswordView.shouldShowNewPasswordConfirmTextFieldError = true
    }
    
    func updateViewForMismatichingPasswordsState() {
        changePasswordView.shouldShowPasswordsMismatchingError = true
    }
    
}
