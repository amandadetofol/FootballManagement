//
//  FinancialPendencieCardViewModel.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 12/06/23.
//

import Foundation

struct FinancialPendencieCardViewModel {
    let title: String
    let isLate: Bool
    let initialValue: Float
    let numberOfDaysLate: Int?
    let admAprooved: Bool
    let hasProof: Bool
    let proofUrl: String?
    let id: Int
    let reason: String 
    var actionLabel: String = "Ver Comprovante"
    var currentIndex: Int?
    var total: Int?
}
