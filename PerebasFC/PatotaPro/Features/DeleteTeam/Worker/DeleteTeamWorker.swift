//
//  DeleteTeamWorker.swift
//  PatotaPro
//
//  Created by Amanda Detofol on 26/11/23.
//

import FirebaseFirestore

protocol DeleteTeamWorkerProtocol {
    func deleteTeam(
        id: String,
        completion: @escaping((Bool)->Void))
}

final class DeleteTeamWorker: DeleteTeamWorkerProtocol {
    
    private let firestoreReference =  Firestore.firestore()
    
    func deleteTeam(
        id: String,
        completion: @escaping((Bool)->Void)) {
            firestoreReference.document("team/\(id)").delete { error in
                guard error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
            
        }
}
