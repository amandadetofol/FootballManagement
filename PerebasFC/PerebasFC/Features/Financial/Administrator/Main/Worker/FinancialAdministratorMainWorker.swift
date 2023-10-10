//
//  FinancialAdministratorMainWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 09/10/23.
//

import Foundation
import FirebaseFirestore

protocol FinancialAdministratorMainWorkerProtocol {
    func getCurrentBalance(completion: @escaping((DocumentSnapshot?)->Void))
}

final class FinancialAdministratorMainWorker: FinancialAdministratorMainWorkerProtocol {
    
    private let firebaseFirestoreProvider = Firestore.firestore().document("financial/balance")
    
    func getCurrentBalance(completion: @escaping((DocumentSnapshot?)->Void)){
        firebaseFirestoreProvider.getDocument { documentSnapshot, error in
            guard error == nil,
                  let documentSnapshot else {
                completion(nil)
                return
            }
            completion(documentSnapshot)
        }
    }
    
}
