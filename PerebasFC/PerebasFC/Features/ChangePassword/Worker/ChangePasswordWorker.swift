//
//  ChangePasswordWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/06/23.
//

import Foundation
import FirebaseAuth

protocol ChangePasswordWorkerProtocol {
    func sendPasswordChangeToServer(
        newPassword: String,
        completion: @escaping ((Bool) -> Void))
}

final class ChangePasswordWorker: ChangePasswordWorkerProtocol {
    
    private let firebaseAuthProvider = Auth.auth()
    
    func sendPasswordChangeToServer(
        newPassword: String,
        completion: @escaping ((Bool) -> Void)) {
            firebaseAuthProvider.currentUser?.updatePassword(to: newPassword, completion: { error in
                guard error == nil else {
                    completion(false)
                    return
                }
                
                completion(true)
            })
        }
    
}
