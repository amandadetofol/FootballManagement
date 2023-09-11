//
//  ForgotPasswordWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 22/05/23.
//

import Foundation
import Firebase

protocol ForgotPasswordWorkerProtocol {
    func sendLinkTo(
        email: String,
        _ operationSucceded: @escaping ((Bool) -> Void))
}

final class ForgotPasswordWorker: ForgotPasswordWorkerProtocol {
    
    private let authProvider = Auth.auth()
    
    func sendLinkTo(
        email: String,
        _ operationSucceded: @escaping ((Bool) -> Void)) {
            authProvider.sendPasswordReset(withEmail: email) { error in
                guard (error == nil) else {
                    operationSucceded(false)
                    return
                }
                operationSucceded(true)
            }
    }
    
}
