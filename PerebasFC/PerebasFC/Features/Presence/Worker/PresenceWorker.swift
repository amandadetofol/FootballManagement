//
//  PresenceWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/09/23.
//

import Foundation
import FirebaseFirestore

protocol PresenceWorkerProtocol {
    func getUsers(id: String, completion: @escaping ((QuerySnapshot?, Bool) -> Void ))
    func savePresence(presence: [PresenceCardViewModel], completion: @escaping ((Bool) -> Void ), id: String)
}

final class PresenceWorker: PresenceWorkerProtocol {
    
    private let usersFirebaseReference = Firestore.firestore().collection("perebasfc")
    private let gamelistFirebaseReference = Firestore.firestore().collection("gamelist")
    
    func getUsers(id: String, completion: @escaping ((QuerySnapshot?, Bool) -> Void )) {
        gamelistFirebaseReference.document(id).collection("presence").getDocuments { [weak self] querySnapShot, error in
            guard error == nil,
                  let self else {
                completion(nil, false)
                return
            }
            
            if querySnapShot?.documents.isEmpty ?? true {
                self.usersFirebaseReference.getDocuments { querySnapshot, error in
                    guard error == nil else {
                        completion(nil, false)
                        return
                    }
                    completion(querySnapshot, false)
                }
                
            } else {
                completion(querySnapShot, true)
            }
        }
    }
    
    func savePresence(presence: [PresenceCardViewModel], completion: @escaping ((Bool) -> Void ), id: String){
        presence.forEach { person in
            gamelistFirebaseReference.document("\(id)/presence/\(person.name)").setData(
                ["name" : person.name,
                 "waspresent" : person.wasPresent,
                ])
        }
        completion(true)
    }
    
}
