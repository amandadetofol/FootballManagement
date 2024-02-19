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
                if !(newItem.userEmail?.lowercased().contains("selecionar") ?? false) {
                    addNewCreditForSpecificParticipant(newItem: newItem) { succeded in
                        completion(succeded)
                    }
                } else {
                    addNewCredit(newItem: newItem) { succeded in
                        completion(succeded)
                    }
                }
                
                
            case .newDebit:
                if !(newItem.userEmail?.lowercased().contains("selecionar") ?? false) {
                    addNewDebitForSpecificParticipant(newItem: newItem) { succeded in
                        completion(succeded)
                    }
                } else {
                    addNewDebit(newItem: newItem) { succeded in
                        completion(succeded)
                    }
                }
                
            }
        }
    
    //MARK: Private methods
    private func addNewCreditForSpecificParticipant(
        newItem: NewItemModel,
        completion: @escaping((Bool) -> Void)){
            guard let email = newItem.userEmail?.replacingOccurrences(of: " ", with: "") else { return }
            Firestore.firestore()
                .document("\(Session.shared.teamId ?? "")/financial/team/credit/person/\(email)-\(newItem.date.toString().replacingOccurrences(of: "/", with: "-"))-\(newItem.eventValue)")
                .setData([
                    "eventName": newItem.eventName,
                    "eventValue": newItem.eventValue,
                    "date": newItem.date.toString(),
                    "type": newItem.type.rawValue,
                    "splitBeetweenTeamMember": newItem.splitBeetweenTeamMember ?? false ,
            ])
            
            Firestore.firestore().collection("\(Session.shared.teamId ?? "")/\(email)/comum-financeiro").getDocuments { [weak self] querySnapShot, error in
                guard error == nil,
                      let querySnapShot else {
                    completion(false)
                    return
                }
                
                let count = querySnapShot.documents.count
                Firestore.firestore().document("\(Session.shared.teamId ?? "")/\(email)/comum-financeiro/\(count+1)").setData(
                    ["admAprooved" : true,
                     "expectedValue": Float(newItem.eventValue) ?? 0.0,
                     "hasProof": false,
                     "initialValue": Float(newItem.eventValue) ?? 0.0,
                     "numberOfDaysLate": 0,
                     "proofUrl": "",
                     "reason": "Adicionado via sistema.",
                     "title": newItem.eventName,
                     "userName" : email
                    ]
                )
                completion(true)
            }
            
    }
    
    private func addNewDebitForSpecificParticipant(
        newItem: NewItemModel,
        completion: @escaping((Bool) -> Void)){
            guard let email = newItem.userEmail?.replacingOccurrences(of: " ", with: "") else { return }
            Firestore.firestore()
                .document("\(Session.shared.teamId ?? "")/financial/team/debt/person/\(email)-\(newItem.date.toString().replacingOccurrences(of: "/", with: "-"))-\(newItem.eventValue)")
                .setData([
                    "eventName": newItem.eventName,
                    "eventValue": newItem.eventValue,
                    "date": newItem.date.toString(),
                    "type": newItem.type.rawValue,
                    "splitBeetweenTeamMember": newItem.splitBeetweenTeamMember ?? false,
            ])
            
            Firestore.firestore().collection("\(Session.shared.teamId ?? "")/\(email)/comum-financeiro").getDocuments {  querySnapShot, error in
                guard error == nil,
                      let querySnapShot else {
                    completion(false)
                    return
                }
                
                let count = querySnapShot.documents.count
                Firestore.firestore().document("\(Session.shared.teamId ?? "")/\(email)/comum-financeiro/\(count+1)").setData(
                    ["admAprooved" : false,
                     "expectedValue": Float(newItem.eventValue) ?? 0.0,
                     "hasProof": false,
                     "initialValue": Float(newItem.eventValue) ?? 0.0,
                     "numberOfDaysLate": 0,
                     "proofUrl": "",
                     "reason": "Aguardando comprovante",
                     "title": newItem.eventName,
                     "userName" : email
                    ]
                )
                completion(true)
            }
            
    }
    
    private func addNewDebit(
        newItem: NewItemModel,
        completion: @escaping((Bool) -> Void)){
            
            Firestore.firestore()
                .document("\(Session.shared.teamId ?? "")/financial/team/debt/general/\(newItem.date.toString().replacingOccurrences(of: "/", with: "-"))-\(newItem.eventValue)")
                .setData([
                    "eventName": newItem.eventName,
                    "eventValue": newItem.eventValue,
                    "date": newItem.date.toString(),
                    "type": newItem.type.rawValue,
                ])
            
            if newItem.splitBeetweenTeamMember ?? false {
                Firestore.firestore().collection("\(Session.shared.teamId ?? "")").getDocuments { [weak self] querySnapShot, error in
                    guard error == nil,
                          let querySnapShot,
                          let self else {
                        completion(false)
                        return
                    }
                    
                    var newItemModelForParticipant = newItem
                    newItemModelForParticipant.eventValue = String(((Int(newItem.eventValue) ?? 0)/querySnapShot.documents.count))
                    
                    querySnapShot.documents.forEach { document in
                        guard let email = document["email"] as? String else { return }
                        newItemModelForParticipant.userEmail = email 
                        self.addNewDebitForSpecificParticipant(newItem: newItemModelForParticipant) { _ in }
                    }
                    completion(true)
                }
            } else {
                Firestore.firestore().document("\(Session.shared.teamId ?? "")/financial/team/balance").getDocument { document, error in
                    guard error == nil,
                          let document else {
                        completion(false)
                        return
                    }
                    
                    let currentBalance = document["balance"] as? Int ?? 0
                    
                    Firestore.firestore().document("\(Session.shared.teamId ?? "")/financial/team/balance").setData(
                        ["balance" : (currentBalance - (Int(newItem.eventValue) ?? 0))]
                    )
                    
                    Firestore.firestore()
                        .document("\(Session.shared.teamId ?? "")/financial/team/debt/general/\(newItem.date.toString().replacingOccurrences(of: "/", with: "-"))-\(newItem.eventValue)")
                        .updateData(["balance" : (currentBalance - (Int(newItem.eventValue) ?? 0))])
                    
                    completion(true)
                }
            }
        }
    
    private func addNewCredit(
        newItem: NewItemModel,
        completion: @escaping((Bool) -> Void)){
             
            Firestore.firestore()
                .document("\(Session.shared.teamId ?? "")/financial/team/credit/general/\(newItem.date.toString().replacingOccurrences(of: "/", with: "-"))-\(newItem.eventValue)")
                .setData([
                    "eventName": newItem.eventName,
                    "eventValue": newItem.eventValue,
                    "date": newItem.date.toString(),
                    "type": newItem.type.rawValue,
                    "splitBeetweenTeamMember": newItem.splitBeetweenTeamMember ?? false ,
                ])
            
            Firestore.firestore().document("\(Session.shared.teamId ?? "")/financial/team/balance").getDocument { document, error in
                guard error == nil,
                      let document else {
                    completion(false)
                    return
                }
                
                let currentBalance = document["balance"] as? Int ?? 0
                
                Firestore.firestore().document("\(Session.shared.teamId ?? "")/financial/team/balance").setData(
                    ["balance" : (currentBalance + (Int(newItem.eventValue) ?? 0))]
                )
                
                Firestore.firestore()
                    .document("\(Session.shared.teamId ?? "")/financial/debt/team/general/\(newItem.date.toString().replacingOccurrences(of: "/", with: "-"))-\(newItem.eventValue)")
                    .updateData(["balance" : (currentBalance - (Int(newItem.eventValue) ?? 0))])
                
                completion(true)
            }
        }
}
