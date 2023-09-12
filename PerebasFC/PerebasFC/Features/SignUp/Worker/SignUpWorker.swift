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
            if user.isAdm {
                checkIfAlreadyHasAnyAdm { [weak self] alreadyHaveAdm in
                    guard let self else { return }
                    
                    if alreadyHaveAdm {
                        completion(false)
                        return
                    } else {
                        self.addUser(user: user) { succeded in
                            completion(succeded)
                        }
                    }
                }
            } else {
                self.addUser(user: user) { succeded in
                    completion(succeded)
                }
            }
        }
    
    //MARK: Private methods
    private func addUser(
        user: NewUserModel,
        completion: @escaping ((Bool) -> Void)){
            Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] (result, error) in
                guard let self else { return }
                
                guard error == nil else {
                    completion(false)
                    return
                }
                self.firestoreProvider.collection("perebasfc").document(user.email).setData(
                    ["email": user.email,
                     "senha": user.password,
                     "isAdm": user.isAdm])
                completion(true)
            }
        }
    
    private func checkIfAlreadyHasAnyAdm(completion: @escaping((Bool)->Void)){
        let userReferece = firestoreProvider.collection("perebasfc")
        userReferece.getDocuments { data, error in
            guard let data = data,
                  error == nil else {
                completion(false)
                return
            }
            
            if data.documents.isEmpty {
                completion(false)
                return
            }
            
            var hasAdm = false
            data.documents.forEach { recoveredDocument in
                guard let recoveredIsAdm = recoveredDocument["isAdm"] as? Bool else {
                    completion(false)
                    return
                }
                
                if recoveredIsAdm {
                    hasAdm = true
                }
                
            }
            
            completion(hasAdm)
        }
    }
    
}
