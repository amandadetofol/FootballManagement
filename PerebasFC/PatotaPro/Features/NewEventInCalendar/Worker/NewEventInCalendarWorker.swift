//
//  NewEventInCalendarWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/07/23.
//

import Foundation
import FirebaseFirestore

protocol NewEventInCalendarWorkerProtocol {
    func saveNewEventInCalendar(
        _ model: NewEventInCalendarViewModel,
        completion: @escaping((Bool)->Void))
}

final class NewEventInCalendarWorker: NewEventInCalendarWorkerProtocol {
    
    private let firebaseEventsReference = Firestore.firestore().collection("\(Session.shared.teamId ?? "")/teamEvents/events")
    
    func saveNewEventInCalendar(
        _ model: NewEventInCalendarViewModel,
        completion: @escaping ((Bool) -> Void)) {
        
            firebaseEventsReference.document("\(model.selectedDate.removeHour()?.replacingOccurrences(of: "/", with: "-") ?? "")-\(model.time)").setData([
                "selectedDate": model.selectedDate.toString(),
                "eventName": model.eventName,
                "time": model.time,
                "allowedToBringCompanions": model.allowedToBringCompanions,
                "numberOfCompanios": model.numberOfCompanios ?? 0,
            ])
            completion(true)
            
    }
    
}
