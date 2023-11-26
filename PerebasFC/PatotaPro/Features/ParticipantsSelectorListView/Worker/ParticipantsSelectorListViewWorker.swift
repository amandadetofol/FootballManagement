//
//  ParticipantsSelectorListViewWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 04/09/23.
//

import Foundation
import FirebaseFirestore

protocol ParticipantsSelectorListViewWorkerProtocol {
    func getParticipants(completion: @escaping((QuerySnapshot?)-> Void))
}

final class ParticipantsSelectorListViewWorker: ParticipantsSelectorListViewWorkerProtocol {
    
    private let firebaseFirestoreProvider = Firestore.firestore().collection(Session.shared.teamId ?? "")
    
    func getParticipants(completion: @escaping ((QuerySnapshot?) -> Void)) {
        firebaseFirestoreProvider.getDocuments { querySnapshot, error in
            guard error == nil else {
                completion(nil)
                return
            }
            completion(querySnapshot)
        }
    }
    
}
