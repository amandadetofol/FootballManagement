//
//  FinancialAdministratorHistoryWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 21/08/23.
//

import Foundation

protocol FinancialAdministratorHistoryWorkerProtocol {
    func getFinancialHistory(completion: @escaping(([FinancialAdministratorHistoryViewModel])->Void))
}

final class FinancialAdministratorHistoryWorker: FinancialAdministratorHistoryWorkerProtocol {
    
    func getFinancialHistory(completion: @escaping (([FinancialAdministratorHistoryViewModel]) -> Void)) {
        completion(FinancialAdministratorHistoryWorkerMock.mocks)
    }
    
}

struct FinancialAdministratorHistoryWorkerMock {
    
    static let mocks = [
        historyItem1,
        historyItem2,
        historyItem3,
        historyItem4,
        historyItem5,
        historyItem6,
        historyItem7,
        historyItem8,
        historyItem9,
        historyItem10]
    
    static let historyItem1 = FinancialAdministratorHistoryViewModel(
        date: Date(),
        dayBalance: "1200.00",
        name: "John Doe",
        operationValue: "300.00",
        operatioType: .credit)

    static let historyItem2 = FinancialAdministratorHistoryViewModel(
        date: Date(),
        dayBalance: "980.50",
        name: "Jane Smith",
        operationValue: "50.00",
        operatioType: .credit)

    static let historyItem3 = FinancialAdministratorHistoryViewModel(
        date: Date(),
        dayBalance: "750.20",
        name: "Alice Johnson",
        operationValue: "80.50",
        operatioType: .debit)

    static let historyItem4 = FinancialAdministratorHistoryViewModel(
        date: Date(),
        dayBalance: "500.00",
        name: "Bob Anderson",
        operationValue: "30.00",
        operatioType: .debit)

    static let historyItem5 = FinancialAdministratorHistoryViewModel(
        date: Date(),
        dayBalance: "1500.75",
        name: "Eva Williams",
        operationValue: "150.00",
        operatioType: .credit)

    static let historyItem6 = FinancialAdministratorHistoryViewModel(
        date: Date(),
        dayBalance: "1800.20",
        name: "Michael Brown",
        operationValue: "25.50",
        operatioType: .credit)

    static let historyItem7 = FinancialAdministratorHistoryViewModel(
        date: Date(),
        dayBalance: "200.00",
        name: "Sophia Miller",
        operationValue: "40.00",
        operatioType: .debit)

    static let historyItem8 = FinancialAdministratorHistoryViewModel(
        date: Date(),
        dayBalance: "1200.50",
        name: "William Davis",
        operationValue: "75.00",
        operatioType: .credit)

    static let historyItem9 = FinancialAdministratorHistoryViewModel(
        date: Date(),
        dayBalance: "950.10",
        name: "Olivia Wilson",
        operationValue: "20.10",
        operatioType: .debit)

    static let historyItem10 = FinancialAdministratorHistoryViewModel(
        date: Date(),
        dayBalance: "600.30",
        name: "James Taylor",
        operationValue: "55.20",
        operatioType: .debit)
}
