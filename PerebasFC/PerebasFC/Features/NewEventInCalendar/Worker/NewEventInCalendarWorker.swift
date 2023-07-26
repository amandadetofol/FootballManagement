//
//  NewEventInCalendarWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/07/23.
//

import Foundation

protocol NewEventInCalendarWorkerProtocol {
    func saveNewEventInCalendar(
        _ model: NewEventInCalendarViewModel,
        completion: @escaping((Bool)->Void))
}

final class NewEventInCalendarWorker: NewEventInCalendarWorkerProtocol {
    
    var shouldSucceed = false
    
    func saveNewEventInCalendar(
        _ model: NewEventInCalendarViewModel,
        completion: @escaping ((Bool) -> Void)) {
            completion(shouldSucceed)
    }
    
}
