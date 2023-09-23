//
//  LoginInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 16/05/23.
//

import UIKit

protocol LoginPresenterProtocol {
    func updateViewForInvalidEmailState()
    func updateViewForMandatoryUsernameError()
    func updateViewForMandatoryPasswordError()
}

final class LoginInteractor: LoginInteractorProtocol {
    
    let coordinator: LoginCoordinatorWithLoaderProtocol
    let presenter: LoginPresenterProtocol
    let worker: LoginWorkerProtocol
    
    init(coordinator: LoginCoordinatorWithLoaderProtocol,
         presenter: LoginPresenterProtocol,
         worker: LoginWorkerProtocol){
            self.coordinator = coordinator
            self.presenter = presenter
            self.worker = worker
        }
    
    func goToLogin(_ username: String, _ password: String) {
        var hasError = false
        
        if username.isEmpty {
            presenter.updateViewForMandatoryUsernameError()
            hasError = true
        }
        
        if !username.isValidEmail() {
            presenter.updateViewForInvalidEmailState()
            hasError = true
        }
        
        if password.isEmpty {
            presenter.updateViewForMandatoryPasswordError()
            hasError = true
        }
        
        if !hasError {
            coordinator.showLoader()
            worker.login(username: username, password: password) { [weak self] user in
                self?.coordinator.removeLoader()
                if let user = user {
                    self?.coordinator.goToLoggedArea(user: user)
                } else {
                    self?.presentViewForLoginError()
                }
            }
        }
    }
    
    func loginWithGoogle(controller: UIViewController){
        worker.loginWithGoogle(
            controller: controller) { [weak self] user in
                if let user = user {
                    self?.coordinator.removeLoader()
                    self?.coordinator.goToLoggedArea(user: user)
                } else {
                    self?.coordinator.removeLoader()
                    self?.presentViewForLoginError()
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
