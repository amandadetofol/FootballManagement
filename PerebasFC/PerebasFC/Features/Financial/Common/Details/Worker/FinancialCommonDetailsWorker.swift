//
//  FinancialCommonDetailsWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 14/09/23.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

protocol FinancialCommonDetailsWorkerProtocol {
    func addProof(
        itemId: Int,
        proofData: Data,
        completion: @escaping((Bool)->Void))
}

final class FinancialCommonDetailsWorker: FinancialCommonDetailsWorkerProtocol {
    
    private let firestoreProvider = Firestore.firestore()
    private let firebaseStorageProvider = Storage.storage().reference()
    
    func addProof(
        itemId: Int,
        proofData: Data,
        completion: @escaping((Bool)->Void)) {
            let documentReference = firebaseStorageProvider
                .child("financeiro/comprovantes/\(Session.shared.loggedUserEmail ?? "")/\(itemId).jpg")
            documentReference.putData(proofData, metadata: nil) { [weak self] (metadata, error) in
                guard error == nil,
                    let self else {
                    completion(false)
                    return
                }
                
                documentReference.downloadURL { url, error in
                    guard error == nil,
                        let url = url else {
                        completion(false)
                        return
                    }
                    
                    self.addProofUrlToFirestore(
                        itemId: itemId,
                        proofUrl: url.absoluteString)
                    completion(true)
                }
            }
        }
    
    //MARK: Private method
    private func addProofUrlToFirestore(
        itemId: Int,
        proofUrl: String){
            let email = Session.shared.loggedUserEmail ?? ""
            let userReference = Firestore.firestore().collection("perebasfc/")
            let financialReference = userReference.document(email).collection("comum-financeiro").document("\(itemId)")
            financialReference.updateData([
                "proofUrl" : proofUrl,
                "hasProof": true,
                "reason": "Aguardando administrador",
            ])
        }
    
}
