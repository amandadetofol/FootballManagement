//
//  ForgotPasswordWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 22/05/23.
//

import Foundation

protocol ForgotPasswordWorkerProtocol {
    func sendLinkTo(
        email: String,
        _ operationSucceded: @escaping ((Bool) -> Void))
}

final class ForgotPasswordWorker: ForgotPasswordWorkerProtocol {
    
    func sendLinkTo(
        email: String,
        _ operationSucceded: @escaping ((Bool) -> Void)) {
            operationSucceded(true)
    }
    
}
