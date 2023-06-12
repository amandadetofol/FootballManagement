//
//  CalendarWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 11/06/23.
//

import Foundation

protocol CalendarWorkerProtol {
    func getCalendarEvents(completion: @escaping (([Int]) -> Void))
}

final class CalendarWorker: CalendarWorkerProtol {
    
    func getCalendarEvents(completion: @escaping (([Int]) -> Void)) {
        completion([04, 16])
    }

}
