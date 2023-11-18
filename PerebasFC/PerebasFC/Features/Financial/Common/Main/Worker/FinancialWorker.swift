//
//  FinancialWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 12/06/23.
//

import Foundation
import FirebaseFirestore

protocol FinancialWorkerProtocol {
    func getFinancialData(completion: @escaping(([QueryDocumentSnapshot]?) -> Void))
}

final class FinancialWorker: FinancialWorkerProtocol {
    
    private let firestoreProvider = Firestore.firestore()
    
    func getFinancialData(completion: @escaping (([QueryDocumentSnapshot]?) -> Void)) {
        let email = Session.shared.loggedUserEmail ?? ""
        let userReference = Firestore.firestore().collection("\(Session.shared.teamId ?? "")")
        let financialReference = userReference.document(email).collection("comum-financeiro")
        financialReference.getDocuments { [weak self] documents, error in
            guard let self,
                error == nil else {
                    completion(nil)
                    return
                }
            completion(documents?.documents)
        }
    }
}
