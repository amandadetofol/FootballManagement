//
//  FinancialAdministratorHistoryWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 21/08/23.
//

import Foundation
import FirebaseFirestore

protocol FinancialAdministratorHistoryWorkerProtocol {
    //credito, debito
    func getFinancialHistory(completion: @escaping(([DocumentSnapshot]?, [DocumentSnapshot]?)->Void))
}

final class FinancialAdministratorHistoryWorker: FinancialAdministratorHistoryWorkerProtocol {
    
    private let firebaseCreditProvider = Firestore.firestore().collection("financial/credit/general")
    private let firebaseDebitProvider = Firestore.firestore().collection("financial/debt/general")
    
    func getFinancialHistory(completion: @escaping(([DocumentSnapshot]?, [DocumentSnapshot]?) -> Void)) {
        var credits: [DocumentSnapshot] = []
        var debits: [DocumentSnapshot] = []
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        firebaseCreditProvider.getDocuments { querySnapshot, error in
            defer {
                dispatchGroup.leave()
            }
            
            guard error == nil, let querySnapshot = querySnapshot else {
                completion(nil, nil)
                return
            }
            
            credits.append(contentsOf: querySnapshot.documents)
        }
        
        dispatchGroup.enter()
        firebaseDebitProvider.getDocuments { querySnapshot, error in
            defer {
                dispatchGroup.leave()
            }
            
            guard error == nil, let querySnapshot = querySnapshot else {
                completion(nil, nil)
                return
            }
            
            debits.append(contentsOf: querySnapshot.documents)
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(credits, debits)
        }
    }
    
}
