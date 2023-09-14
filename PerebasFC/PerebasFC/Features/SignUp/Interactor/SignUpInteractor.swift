//
//  SignUpInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 11/09/23.
//

import Foundation

final class SignUpInteractor: SignUpInteractorProtocol {
    
    private let worker: SignUpWorkerProtocol
    private let presenter: SignUpPresenterProtocol
    private let coordinator: SignUpCoordinatorProtocol
    
    init(
        worker: SignUpWorkerProtocol,
        presenter: SignUpPresenterProtocol,
        coordinator: SignUpCoordinatorProtocol){
            self.worker = worker
            self.presenter = presenter
            self.coordinator = coordinator
        }
    
    func handleCreateNewUserButtonTap(user: NewUserModel) {
        var hasError = false
        
        if user.email.isEmpty {
            presenter.setupViewForEmptyEmailErrorState()
            hasError = true
        }
        
        if user.confirmPassword.isEmpty {
            presenter.setupViewForEmptyConfirmPasswordFieldState()
            hasError = true
        }
        
        if user.password.isEmpty {
            presenter.setupViewForEmptyPasswordFieldState()
            hasError = true
        }
        
        if user.password != user.confirmPassword {
            presenter.setupViewForMismatchingPasswordsErrorState()
            hasError = true
        }
        
        if hasError {
            return
        }
        
        coordinator.showLoading()
        worker.createNewUser(user: user) { [weak self] succeded in
            guard let self else { return }
            self.coordinator.removeLoading()
            self.coordinator.showAlert(succeded: succeded)
        }
    }
    
}