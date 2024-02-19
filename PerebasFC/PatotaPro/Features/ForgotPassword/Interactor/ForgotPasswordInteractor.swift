//
//  ForgotPasswordInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 22/05/23.
//

import Foundation

protocol ForgotPasswordPresenterProtocol {
    func updateEmailTextfieldContent(with email: String)
    func updateEmailTextfieldForError(using message: String)
}

final class ForgotPasswordInteractor: ForgotPasswordInteractorProtocol {
    
    let email: String
    let worker: ForgotPasswordWorkerProtocol
    let coordinator: ForgotPasswordCoordinatorProtocol
    let presenter: ForgotPasswordPresenterProtocol
    
    init(worker: ForgotPasswordWorkerProtocol,
         coordinator: ForgotPasswordCoordinatorProtocol,
         presenter: ForgotPasswordPresenterProtocol,
         email: String){
        self.worker = worker
        self.coordinator = coordinator
        self.presenter = presenter
        self.email = email
    }
    
    func viewDidLoad() {
        presenter.updateEmailTextfieldContent(with: self.email)
    }
    
    func recoverPassword(email: String) {
        if email.isEmpty {
            presenter.updateEmailTextfieldForError(using: "E-mail inválido")
        } else {
            coordinator.showLoading { [weak self] in
                guard let self else { return }
                self.worker.sendLinkTo(
                    email: email) { operationSucceded in
                        
                        switch operationSucceded {
                        case true:
                            self.coordinator.removeLoading {
                                self.coordinator.goToShowSendResetLinkAlert(email: email)
                            }
                        case false:
                            self.coordinator.removeLoading {
                                self.coordinator.goToShowSendResetErrorAlert()
                                
                            }
                        }
                    }
            }
        }
    }
    
}
