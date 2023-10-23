//
//  AdministratorPendenciesDetailsNotificationWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 21/08/23.
//

import NotificationCenter
import FirebaseFirestore
import MessageUI

protocol AdministratorPendenciesDetailsNotificationWorkerProtocol {
    func updateItemInFirebase(
        model: FinancialAdministratorPendenciesListCardModel,
        completion: @escaping((Bool)->Void))
}

final class AdministratorPendenciesDetailsNotificationWorker: AdministratorPendenciesDetailsNotificationWorkerProtocol {
    
    private let firebaseProvider = Firestore.firestore().collection("perebasfc")
    
    func updateItemInFirebase(
        model: FinancialAdministratorPendenciesListCardModel,
        completion: @escaping ((Bool) -> Void)) {
            let documentRef = "/\(model.userName)/comum-financeiro/\(model.id ?? "1")"
            
            let data: [String: Any] = [
                "expectedValue": model.daysLateValue,
                "hasProof": model.proofUrl?.isEmpty ?? false,
                "initialValue": Float(model.value) ?? 0.0,
                "numberOfDaysLate": model.daysLate,
                "proofUrl": model.proofUrl ?? "",
                "reason": model.name,
                "title": model.title,
                "userName": model.userName
            ]
            
            firebaseProvider.document(documentRef).updateData(data) { error in
                if let error = error {
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
    
}

