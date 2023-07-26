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
    let time: Date
    let allowedToBringCompanions: Bool
    let numberOfCompanios: Int? 
}
