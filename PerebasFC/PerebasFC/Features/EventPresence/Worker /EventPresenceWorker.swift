//
//  EventPresenceWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/09/23.
//

import Foundation
import FirebaseFirestore

protocol EventPresenceWorkerProtocol {
    func getEventPresenceModel(
        itemId: String,
        completion: @escaping((QuerySnapshot?) -> Void))
}

final class EventPresenceWorker: EventPresenceWorkerProtocol {
    
    private let firebaseFirestoreProvider = Firestore.firestore().collection("events")
 
    func getEventPresenceModel(
        itemId: String,
        completion: @escaping((QuerySnapshot?) -> Void)) {
            firebaseFirestoreProvider.document(itemId).collection("prensence").getDocuments { querySnapShot, error in
                guard let querySnapShot,
                      error == nil else {
                    completion(nil)
                    return
                }
                completion(querySnapShot)
            }
        }
    
}
