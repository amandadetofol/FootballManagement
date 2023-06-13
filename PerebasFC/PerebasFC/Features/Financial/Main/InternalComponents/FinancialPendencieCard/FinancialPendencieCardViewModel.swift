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
    let hasProof: Bool
    let proofUrl: String?
    var actionLabel: String = "Ver Comprovante"
}
