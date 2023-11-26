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
    var id: String?
    var day: Int {
        get {
            guard let startIndex = id?.startIndex,
                  let endIndex = id?.index(startIndex, offsetBy: 2),
                  let substring = id?[startIndex..<endIndex] else { return 0}
            if let numeroInteiro = Int(String(substring)) {
                return numeroInteiro
            } else {
                return 0
            }
        }
    }
}
