//
//  LoginWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 16/05/23.
//

import Foundation

protocol LoginWorkerProtocol {
    func login(
        username: String,
        password: String,
        isAdm: Bool,
        _ completion: @escaping ((User?) -> Void))
}

final class LoginWorker: LoginWorkerProtocol {
    
    func login(
        username: String,
        password: String,
        isAdm: Bool,
        _ completion: @escaping ((User?) -> Void)) {
            completion(
                User(
                    firstName: "Usuário",
                    lastName: "de Teste",
                    warnings: nil,
                    isAdm: false))
    }
    
}
