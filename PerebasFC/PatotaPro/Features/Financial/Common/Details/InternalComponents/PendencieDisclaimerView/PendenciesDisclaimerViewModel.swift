//
//  PendenciesDisclaimerViewModel.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 13/06/23.
//

import Foundation

struct PendenciesDisclaimerViewModel {
    let itemName: String
    let initialValue: Float
    let daysLate: Int
    let otherReason: String?
    
    var totalValue: Float {
        get {
            return initialValue + Float(daysLate)
        }
    }
}
