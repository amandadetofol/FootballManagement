//
//  ChangePasswordPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 15/09/23.
//

import Foundation

protocol ChangePasswordPresenterProtocol {
    func updateNewPasswordTextFieldForErrorState()
    func updateConfirmNewPasswordTextFieldForErrorState()
    func updateViewForMismatichingPasswordsState()
}

protocol ChangePasswordViewProtocol: AnyObject {
    func updateNewPasswordTextFieldForErrorState()
    func updateConfirmNewPasswordTextFieldForErrorState()
    func updateViewForMismatichingPasswordsState()
}

final class ChangePasswordPresenter: ChangePasswordPresenterProtocol {
    
    weak var view: ChangePasswordViewProtocol?
    
    func updateNewPasswordTextFieldForErrorState() {
        view?.updateNewPasswordTextFieldForErrorState()
    }
    
    func updateConfirmNewPasswordTextFieldForErrorState() {
        view?.updateConfirmNewPasswordTextFieldForErrorState()
    }
    
    func updateViewForMismatichingPasswordsState() {
        view?.updateViewForMismatichingPasswordsState()
    }
    
}
