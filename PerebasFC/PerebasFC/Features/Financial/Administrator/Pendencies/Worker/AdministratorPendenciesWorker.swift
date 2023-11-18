//
//  AdministratorPendenciesWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 19/08/23.
//

import Foundation
import FirebaseFirestore

protocol AdministratorPendenciesWorkerProtocol {
    func getUsersPendencies(completion: @escaping(([DocumentSnapshot]?)->Void))
}

final class AdministratorPendenciesWorker: AdministratorPendenciesWorkerProtocol {
    
    private let firebaseFirestoreProvider = Firestore.firestore().collection(Session.shared.teamId ?? "")
    
    func getUsersPendencies(completion: @escaping (([DocumentSnapshot]?) -> Void)) {
        firebaseFirestoreProvider.getDocuments { querySnapshot, error in
            guard let querySnapshot = querySnapshot, error == nil else {
                completion(nil)
                return
            }
            
            var documents: [DocumentSnapshot] = []
            let dispatchGroup = DispatchGroup()
            
            for document in querySnapshot.documents {
                guard let documentEmail = document["email"] as? String else {
                    continue
                }
                
                dispatchGroup.enter()
                
                Firestore.firestore().collection("\(Session.shared.teamId ?? "")/\(documentEmail)/comum-financeiro").getDocuments { querySnapshot, error in
                    defer {
                        dispatchGroup.leave()
                    }
                    
                    if let error = error {
                        return
                    }
                    
                    if let querySnapshot = querySnapshot {
                        documents.append(contentsOf: querySnapshot.documents)
                    }
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(documents)
            }
        }
    }

}

