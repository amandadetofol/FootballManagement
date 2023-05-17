//
//  LoginInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 16/05/23.
//

import Foundation

protocol LoginPresenterProtocol {
    func updateViewForMandatoryUsernameError()
    func updateViewForMandatoryPasswordError()
}

final class LoginInteractor: LoginInteractorProtocol {
    
    let coordinator: LoginCoordinatorProtocol
    let presenter: LoginPresenterProtocol
    let worker: LoginWorkerProtocol
    
    init(coordinator: LoginCoordinatorProtocol,
         presenter: LoginPresenterProtocol,
         worker: LoginWorkerProtocol){
            self.coordinator = coordinator
            self.presenter = presenter
            self.worker = worker
        }
    
    func goToLogin(_ username: String, _ password: String) {
        if username.isEmpty {
            presenter.updateViewForMandatoryUsernameError()
        }
        
        if password.isEmpty {
            presenter.updateViewForMandatoryPasswordError()
        }
        
        if !password.isEmpty && !username.isEmpty {
            worker.login(username: username, password: password) { [weak self] succeeded in
                if succeeded {
                    self?.coordinator.goToLoggedArea()
                } else {
                    self?.presentViewForLoginError()
                }
            }
        }
    }
    
    func presentViewForLoginError(){
        coordinator.goToLoginErrorView()
    }
    
    func goToNewMemeberMessageView() {
        coordinator.goToNewMemeberMessageView()
    }
    
    func goToForgotPassword(_ username: String) {
        coordinator.goToForgotPassword(username: username)
    }
    
}
