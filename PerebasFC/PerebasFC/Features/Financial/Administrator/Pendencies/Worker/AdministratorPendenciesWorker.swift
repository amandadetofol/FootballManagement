//
//  AdministratorPendenciesWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 19/08/23.
//

import Foundation

protocol AdministratorPendenciesWorkerProtocol {
    func getUsersPendencies(completion: @escaping((AdministratorPendenciesViewModel)->Void))
}

final class AdministratorPendenciesWorker: AdministratorPendenciesWorkerProtocol {
    
    func getUsersPendencies(completion: @escaping ((AdministratorPendenciesViewModel) -> Void)) {
        completion(
            AdministratorPendenciesViewModel(
                items: FinancialAdministratorPendenciesListCardModelMock.mocks))
    }
    
}

struct FinancialAdministratorPendenciesListCardModelMock {
    
    static var mocks = [
        mock1,
        mock2,
        mock3,
        mock4,
        mock5,
        mock6,
        mock7,
        mock8,
        mock9,
        mock10]
    
    static var mock1: FinancialAdministratorPendenciesListCardModel {
        return FinancialAdministratorPendenciesListCardModel(title: "Invoice #123",
                                                             value: "500.00",
                                                             name: "John Doe",
                                                             daysLate: 5,
                                                             proofUrl: nil)
    }
    
    static var mock2: FinancialAdministratorPendenciesListCardModel {
        return FinancialAdministratorPendenciesListCardModel(title: "Unpaid Bill",
                                                             value: "750.50",
                                                             name: "Jane Smith",
                                                             daysLate: 10,
                                                             proofUrl: "https://example.com/proof1.pdf")
    }
    
    static var mock3: FinancialAdministratorPendenciesListCardModel {
        return FinancialAdministratorPendenciesListCardModel(title: "Overdue Payment",
                                                             value: "200.00",
                                                             name: "Michael Johnson",
                                                             daysLate: 2,
                                                             proofUrl: "https://example.com/proof2.pdf")
    }
    
    static var mock4: FinancialAdministratorPendenciesListCardModel {
        return FinancialAdministratorPendenciesListCardModel(title: "Pending Transaction",
                                                             value: "1200.75",
                                                             name: "Sarah Brown",
                                                             daysLate: 8,
                                                             proofUrl: nil)
    }
    
    static var mock5: FinancialAdministratorPendenciesListCardModel {
        return FinancialAdministratorPendenciesListCardModel(title: "Invoice Overdue",
                                                             value: "300.00",
                                                             name: "David Lee",
                                                             daysLate: 15,
                                                             proofUrl: "https://example.com/proof3.pdf")
    }
    
    static var mock6: FinancialAdministratorPendenciesListCardModel {
        return FinancialAdministratorPendenciesListCardModel(title: "Unresolved Payment",
                                                             value: "980.25",
                                                             name: "Emily White",
                                                             daysLate: 3,
                                                             proofUrl: nil)
    }
    
    static var mock7: FinancialAdministratorPendenciesListCardModel {
        return FinancialAdministratorPendenciesListCardModel(title: "Outstanding Bill",
                                                             value: "150.50",
                                                             name: "Robert Green",
                                                             daysLate: 12,
                                                             proofUrl: "https://example.com/proof4.pdf")
    }
    
    static var mock8: FinancialAdministratorPendenciesListCardModel {
        return FinancialAdministratorPendenciesListCardModel(title: "Overdue Expense",
                                                             value: "75.00",
                                                             name: "Olivia Clark",
                                                             daysLate: 6,
                                                             proofUrl: nil)
    }
    
    static var mock9: FinancialAdministratorPendenciesListCardModel {
        return FinancialAdministratorPendenciesListCardModel(title: "Delayed Payment",
                                                             value: "450.20",
                                                             name: "William Turner",
                                                             daysLate: 9,
                                                             proofUrl: "https://example.com/proof5.pdf")
    }
    
    static var mock10: FinancialAdministratorPendenciesListCardModel {
        return FinancialAdministratorPendenciesListCardModel(title: "Payment Due",
                                                             value: "800.60",
                                                             name: "Sophia Brown",
                                                             daysLate: 4,
                                                             proofUrl: nil)
    }
}
