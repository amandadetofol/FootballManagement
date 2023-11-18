//
//  CalendarWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 11/06/23.
//

import Foundation
import FirebaseFirestore

protocol CalendarWorkerProtol {
    func getCalendarEvents(completion: @escaping ((QuerySnapshot?) -> Void))
    func saveNewUserInPresenceList(
        numberOfCompanions: Int,
        itemId: String,
        completion: @escaping ((Bool) -> Void))
}

final class CalendarWorker: CalendarWorkerProtol {
    
    private let fireabaseFirestoreProvider = Firestore.firestore().collection("\(Session.shared.teamId ?? "")/teamEvents/events")
    private let fireabaseSingleDocumentFirestoreProvider = Firestore.firestore()
    
    func getCalendarEvents(completion: @escaping ((QuerySnapshot?) -> Void)) {
        fireabaseFirestoreProvider.getDocuments { querysnapshot, error in
            guard let querysnapshot,
                  error == nil else {
                completion(nil)
                return
            }
            completion(querysnapshot)
        }
    }
    
    func saveNewUserInPresenceList(
        numberOfCompanions: Int,
        itemId: String,
        completion: @escaping ((Bool) -> Void)){
            fireabaseSingleDocumentFirestoreProvider
                .document("\(Session.shared.teamId ?? "")/teamEvents/events/\(itemId)/prensence/\(Session.shared.loggedUserEmail ?? "")").setData(
                    ["presence": true,
                     "numberOfCompanions": numberOfCompanions])
            completion(true)
        }

}
