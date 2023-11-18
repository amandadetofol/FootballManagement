//
//  ParticipantsManagerWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/08/23.
//

import Foundation
import FirebaseFirestore

protocol ParticipantsManagerWorkerProtocol {
    func getParticipants(completion: @escaping((QuerySnapshot?) -> Void))
}

final class ParticipantsManagerWorker: ParticipantsManagerWorkerProtocol {
    
    private let usersFirebaseReference = Firestore.firestore().collection(Session.shared.teamId ?? "")
    
    func getParticipants(completion: @escaping ((QuerySnapshot?) -> Void)) {
        usersFirebaseReference.getDocuments { querySnapshot, error in
            guard error == nil else {
                completion(nil)
                return
            }
            completion(querySnapshot)
        }
    }
    
}
