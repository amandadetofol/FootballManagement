//
//  NewEventInCalendarViewModel.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/07/23.
//

import UIKit

struct NewEventInCalendarViewModel {
    let selectedDate: Date
    let eventName: String
    let time: String
    let allowedToBringCompanions: Bool
    let numberOfCompanios: Int?
    
    var day: Int {
        get {
            let calendar = Calendar.current
            return calendar.component(.day, from: selectedDate)
        }
    }
}
