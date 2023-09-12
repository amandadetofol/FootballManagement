//
//  SignUpWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 11/09/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol SignUpWorkerProtocol {
    func createNewUser(
        user: NewUserModel,
        completion: @escaping((Bool) -> Void))
}

final class SignUpWorker: SignUpWorkerProtocol {
    
    private let firestoreProvider = Firestore.firestore()
    private let authenticationProvider = Auth.auth()
    
    func createNewUser(
        user: NewUserModel,
        completion: @escaping ((Bool) -> Void)) {
            Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] (result, error) in
                guard error == nil else {
                    completion(false)
                    return
                }
                
                self?.firestoreProvider.collection("perebasfc").document(user.email).setData(
                    ["email": user.email,
                     "senha": user.password,
                     "isAdm": user.isAdm])
                
                completion(true)
            }
        }
    
}
