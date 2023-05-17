//
//  LoginPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 16/05/23.
//

import Foundation

protocol LoginViewProtocol: AnyObject {
    func updateViewForMandatoryUsernameError()
    func updateViewForMandatoryPasswordError()
}

final class LoginPresenter: LoginPresenterProtocol {

    weak var view: LoginViewProtocol?
    
    func updateViewForMandatoryUsernameError() {
        view?.updateViewForMandatoryUsernameError()
    }
    
    func updateViewForMandatoryPasswordError() {
        view?.updateViewForMandatoryPasswordError()
    }
    
}
