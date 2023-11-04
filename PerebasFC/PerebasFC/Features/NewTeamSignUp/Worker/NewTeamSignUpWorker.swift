//
//  NewTeamSignUpWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 04/11/23.
//

import Foundation

protocol NewTeamSignUpWorkerProtocol {
    func createNewGameOnFirebase(
        model: NewTeamSignUpModel,
        completion: @escaping((Bool)->Void))
}

final class NewTeamSignUpWorker: NewTeamSignUpWorkerProtocol {
    
    func createNewGameOnFirebase(
        model: NewTeamSignUpModel,
        completion: @escaping((Bool)->Void)){
            completion(true)
            //TODO: Call firebase func to add
        }
    
}
