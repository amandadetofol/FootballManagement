//
//  ChangePasswordInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/06/23.
//

import Foundation

final class ChangePasswordInteractor: ChangePasswordInteractorProtocol {
    
    private let worker: ChangePasswordWorkerProtocol
    private let coordinator: ChangePasswordCoordinatorProtocol
    private let presenter: ChangePasswordPresenterProtocol
    
    init(
        worker: ChangePasswordWorkerProtocol,
        coordinator: ChangePasswordCoordinatorProtocol,
        presenter: ChangePasswordPresenterProtocol){
            self.worker = worker
            self.coordinator = coordinator
            self.presenter = presenter
        }
    
    func handleConfirmPasswordChangeButtonTap(changePasswordModel: ChangePasswordModel){
        var hasError = false
        
        if changePasswordModel.newPassword.isEmpty {
            presenter.updateNewPasswordTextFieldForErrorState()
            hasError = true
        }
        
        if changePasswordModel.newPasswordRepetead.isEmpty {
            presenter.updateConfirmNewPasswordTextFieldForErrorState()
            hasError = true
        }
        
        if changePasswordModel.newPassword != changePasswordModel.newPasswordRepetead {
            presenter.updateViewForMismatichingPasswordsState()
            hasError = true
        }
        
        if hasError {
            return
        }
        
        worker.sendPasswordChangeToServer(
            newPassword: changePasswordModel.newPassword) { [weak self] succeded in
                if succeded {
                    self?.coordinator.showSuccessAlertMessage()
                } else {
                    self?.coordinator.showErrorAlertMessage()
                }
            }
    }
    
}
