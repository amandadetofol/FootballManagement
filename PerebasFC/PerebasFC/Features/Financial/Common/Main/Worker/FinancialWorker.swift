//
//  FinancialWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 12/06/23.
//

import Foundation

protocol FinancialWorkerProtocol {
    func getFinancialData(completion: @escaping(([FinancialPendencieCardViewModel]) -> Void))
}

final class FinancialWorker: FinancialWorkerProtocol {
    
    func getFinancialData(completion: @escaping (([FinancialPendencieCardViewModel]) -> Void)) {
        let mock1 = FinancialPendencieCardViewModel(
            title: "Mensalidade",
            isLate: true,
            initialValue: 1500.0,
            numberOfDaysLate: 7,
            hasProof: true,
            proofUrl: "https://exemplo.com/comprovante1",
            actionLabel: "Ver Comprovante"
        )
        
        let mock2 = FinancialPendencieCardViewModel(
            title: "Mensalidade",
            isLate: false,
            initialValue: 2500.0,
            numberOfDaysLate: nil,
            hasProof: false,
            proofUrl: nil,
            actionLabel: "Ver Comprovante"
        )

        let mock3 = FinancialPendencieCardViewModel(
            title: "Mensalidade",
            isLate: false,
            initialValue: 100.0,
            numberOfDaysLate: nil,
            hasProof: true,
            proofUrl: "https://exemplo.com/comprovante3",
            actionLabel: "Ver Comprovante"
        )

        let mock4 = FinancialPendencieCardViewModel(
            title: "Mensalidade",
            isLate: true,
            initialValue: 1200.0,
            numberOfDaysLate: 14,
            hasProof: true,
            proofUrl: "https://exemplo.com/comprovante4",
            actionLabel: "Ver Comprovante"
        )

        let mock5 = FinancialPendencieCardViewModel(
            title: "Mensalidade",
            isLate: false,
            initialValue: 80.0,
            numberOfDaysLate: nil,
            hasProof: false,
            proofUrl: nil,
            actionLabel: "Ver Comprovante"
        )

        let mock6 = FinancialPendencieCardViewModel(
            title: "Mensalidade",
            isLate: true,
            initialValue: 500.0,
            numberOfDaysLate: 30,
            hasProof: false,
            proofUrl: nil,
            actionLabel: "Ver Comprovante"
        )

        let mock7 = FinancialPendencieCardViewModel(
            title: "Mensalidade",
            isLate: false,
            initialValue: 30.0,
            numberOfDaysLate: nil,
            hasProof: true,
            proofUrl: "https://exemplo.com/comprovante7",
            actionLabel: "Ver Comprovante"
        )

        let mock8 = FinancialPendencieCardViewModel(
            title: "Mensalidade",
            isLate: false,
            initialValue: 200.0,
            numberOfDaysLate: nil,
            hasProof: true,
            proofUrl: "https://exemplo.com/comprovante8",
            actionLabel: "Ver Comprovante"
        )
        
        let mock9 = FinancialPendencieCardViewModel(
            title: "Mensalidade",
            isLate: false,
            initialValue: 300.0,
            numberOfDaysLate: nil,
            hasProof: false,
            proofUrl: nil,
            actionLabel: "")

        completion([
            mock1,
            mock2,
            mock3,
            mock4,
            mock5,
            mock6,
            mock7,
            mock8,
            mock9])
    }
    
    
}
