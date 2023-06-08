//
//  ChangePasswordWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/06/23.
//

import Foundation

protocol ChangePasswordWorkerProtocol {
    func sendPasswordChangeToServer(
        oldPassword: String,
        newPassword: String,
        completion: @escaping ((Bool) -> Void))
}

final class ChangePasswordWorker: ChangePasswordWorkerProtocol {
    
    func sendPasswordChangeToServer(
        oldPassword: String,
        newPassword: String,
        completion: @escaping ((Bool) -> Void)) {
            completion(true)
        }
    
}
