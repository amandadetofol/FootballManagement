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
    
    private let firebaseFirestoreProvider = Firestore.firestore().collection("perebasfc")
    
    func getUsersPendencies(completion: @escaping (([DocumentSnapshot]?) -> Void)) {
        firebaseFirestoreProvider.getDocuments { querySnapshot, error in
            guard let querySnapshot, error == nil else {
                completion(nil)
                return
            }
            
            var documents: [DocumentSnapshot] = []
            let dispatchGroup = DispatchGroup()
            
            for document in querySnapshot.documents {
                guard let documentEmail = document["email"] as? String else {
                    completion(nil)
                    return
                }
                
                dispatchGroup.enter()
                
                Firestore.firestore().collection("perebasfc/\(documentEmail)/comum-financeiro").getDocuments { querySnapshot, error in
                    if let querySnapshot = querySnapshot, error == nil {
                        documents.append(contentsOf: querySnapshot.documents)
                    }
                    dispatchGroup.leave()
                }
            }
            
            
            dispatchGroup.notify(queue: .main) {
                completion(documents)
            }
        }
    }
}

