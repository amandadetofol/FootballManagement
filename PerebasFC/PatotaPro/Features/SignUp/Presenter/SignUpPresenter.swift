//
//  SignUpPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 11/09/23.
//

import Foundation

protocol SignUpPresenterProtocol {
    func setupViewForEmptyEmailErrorState()
    func setupViewForEmptyPasswordFieldState()
    func setupViewForEmptyConfirmPasswordFieldState()
    func setupViewForMismatchingPasswordsErrorState()
    func setupViewForInvalidEmailErrorState()
    func setupViewForTeamIdError()
}

protocol SignUpViewProtocol: AnyObject {
    func setupViewForEmptyEmailErrorState()
    func setupViewForEmptyPasswordFieldState()
    func setupViewForEmptyConfirmPasswordFieldState()
    func setupViewForMismatchingPasswordsErrorState()
    func setupViewForInvalidEmailErrorState()
    func setupViewForTeamIdError()
}

final class SignUpPresenter: SignUpPresenterProtocol {
    
    weak var view: SignUpViewProtocol?
    
    func setupViewForEmptyEmailErrorState() {
        view?.setupViewForEmptyEmailErrorState()
    }
    
    func setupViewForEmptyPasswordFieldState() {
        view?.setupViewForEmptyPasswordFieldState()
    }
    
    func setupViewForEmptyConfirmPasswordFieldState() {
        view?.setupViewForEmptyConfirmPasswordFieldState()
    }
    
    func setupViewForMismatchingPasswordsErrorState() {
        view?.setupViewForMismatchingPasswordsErrorState()
    }
    
    func setupViewForInvalidEmailErrorState(){
        view?.setupViewForInvalidEmailErrorState()
    }
    
    func setupViewForTeamIdError(){
        view?.setupViewForTeamIdError()
    }
    
}
