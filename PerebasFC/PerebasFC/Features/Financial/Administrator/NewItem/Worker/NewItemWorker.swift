//
//  NewItemWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 17/08/23.
//

import Foundation
import FirebaseFirestore

protocol NewItemWorkerProtocol {
    func createNewItem(
        newItem: NewItemModel,
        type: FinancialAdministratorActions,
        completion: @escaping((Bool)->Void))
}

final class NewItemWorker: NewItemWorkerProtocol {
    
    func createNewItem(
        newItem: NewItemModel,
        type: FinancialAdministratorActions,
        completion: @escaping((Bool)->Void)) {
            switch type {
            case .history:
                return
            case .pendencies:
                return
            case .newCredit:
                addNewCredit(newItem: newItem) { succeded in
                    completion(succeded)
                }
            case .newDebit:
                return
            }
        }
    
    //MARK: Private methods
    private func addNewCredit(
        newItem: NewItemModel,
        completion: @escaping((Bool) -> Void)){
            
            Firestore.firestore()
                .document("financial/credit/general/\(newItem.date.toString().replacingOccurrences(of: "/", with: "-"))-\(newItem.eventValue)")
                .setData([
                    "eventName": newItem.eventName,
                    "eventValue": newItem.eventValue,
                    "date": newItem.date.toString(),
                    "type": newItem.type.rawValue,
                    "splitBeetweenTeamMember": newItem.splitBeetweenTeamMember ?? false ,
                ])
            
            Firestore.firestore().document("financial/balance").getDocument { document, error in
                guard error == nil,
                      let document else {
                    completion(false)
                    return
                }
                
                let currentBalance = document["balance"] as? Int ?? 0
                
                Firestore.firestore().document("financial/balance").setData(
                    ["balance" : (currentBalance + (Int(newItem.eventValue) ?? 0))]
                )
                completion(true)
            }
        }
}
