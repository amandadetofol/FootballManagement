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
}

final class CalendarWorker: CalendarWorkerProtol {
    
    private let fireabaseFirestoreProvider = Firestore.firestore().collection("events")
    
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

}
