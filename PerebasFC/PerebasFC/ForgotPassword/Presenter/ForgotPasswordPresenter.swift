//
//  ForgotPasswordPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 22/05/23.
//

import Foundation

protocol ForgotPasswordViewProtocol: AnyObject {
    func updateEmailTextfieldContent(with email: String)
    func updateEmailTextfieldForError(using message: String)
}

final class ForgotPasswordPresenter: ForgotPasswordPresenterProtocol {

    weak var view: ForgotPasswordViewProtocol?
    
    func updateEmailTextfieldForError(using message: String) {
        view?.updateEmailTextfieldForError(using: message)
    }
    
    func updateEmailTextfieldContent(with email: String) {
        view?.updateEmailTextfieldContent(with: email)
    }
    
}
