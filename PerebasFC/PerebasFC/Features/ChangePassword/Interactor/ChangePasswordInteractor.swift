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
    
    init(
        worker: ChangePasswordWorkerProtocol,
        coordinator: ChangePasswordCoordinatorProtocol ){
            self.worker = worker
            self.coordinator = coordinator
    }
    
    func handleConfirmPasswordChangeButtonTap(
        oldPassword: String,
        newPassword: String){
            worker.sendPasswordChangeToServer(
                oldPassword: oldPassword,
                newPassword: newPassword) { [weak self] succeded in
                    if succeded {
                        self?.coordinator.showSuccessAlertMessage()
                    } else {
                        self?.coordinator.showErrorAlertMessage()
                    }
                }
        }
    
}
