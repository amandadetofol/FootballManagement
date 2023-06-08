//
//  ChangePasswordViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/06/23.
//

import UIKit

protocol ChangePasswordInteractorProtocol {
    func handleConfirmPasswordChangeButtonTap(
        oldPassword: String,
        newPassword: String)
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
    }
    
}

extension ChangePasswordViewController: ChangePasswordViewDelegate {
   
    func handleConfirmPasswordChangeButtonTap(
        oldPassword: String,
        newPassword: String) {
            interactor.handleConfirmPasswordChangeButtonTap(
                oldPassword: oldPassword,
                newPassword: newPassword)
    }
    
}
