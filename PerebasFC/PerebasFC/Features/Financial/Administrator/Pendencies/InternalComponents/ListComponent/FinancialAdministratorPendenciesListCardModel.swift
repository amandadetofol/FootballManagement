//
//  FinancialAdministratorPendenciesListCardModel.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 19/08/23.
//

import Foundation

struct FinancialAdministratorPendenciesListCardModel {
    let title: String
    let value: String
    let name: String
    let daysLate: Int
    let proofUrl: String?
    var currentIndex: Int?
    var total: Int?
    let userName: String
    var id: String?
    
    var daysLateValue: Float {
        get {
            let value = Float(self.value) ?? 0.0
            return value * Float(self.daysLate)
        }
    }
}
