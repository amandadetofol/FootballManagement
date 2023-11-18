//
//  MapWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 23/08/23.
//

import Foundation
import FirebaseFirestore

protocol MapWorkerProtocol {
    func getLocal(completion: @escaping ((DocumentSnapshot?)-> Void))
    func updateGameLocal(gameLocalNewUrl: String, completion: @escaping((Bool)->Void))
}

final class MapWorker: MapWorkerProtocol {
    
    private let firestoreProvider = Firestore.firestore()
    
    func getLocal(completion: @escaping ((DocumentSnapshot?)-> Void)) {
        firestoreProvider.collection("\(Session.shared.teamId ?? "")/gamelocal/local").document("local").getDocument { documentSnapShot, error in
            guard error == nil,
                  let documentSnapShot = documentSnapShot else { return }
            completion(documentSnapShot)
        }
    }
    
    func updateGameLocal(
        gameLocalNewUrl: String,
        completion: @escaping((Bool)->Void)){
            firestoreProvider.collection("\(Session.shared.teamId ?? "")/gamelocal/local").document("local").setData(["local": gameLocalNewUrl],
                                                                                   completion: { error in
                guard error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            })
            
        }
    
}
