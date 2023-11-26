//
//  SignOutWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 27/07/23.
//

import Foundation
import Firebase

protocol SignOutWorkerProtocol {
    static func signOut(completion: @escaping((Bool)->Void))
}

final class SignOutWorker: SignOutWorkerProtocol {
    
    static func signOut(completion: @escaping((Bool)->Void)) {
        do { try Auth.auth().signOut()
            completion(true)
        } catch {
            completion(false)
        }
    }
    
}
