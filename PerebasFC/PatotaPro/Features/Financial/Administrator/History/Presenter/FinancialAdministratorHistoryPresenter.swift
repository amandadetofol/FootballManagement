//
//  FinancialAdministratorHistoryPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 21/08/23.
//

import Foundation
import FirebaseFirestore

protocol FinancialAdministratorHistoryPresenterProtocol {
    func updateView(credit: [DocumentSnapshot], debit: [DocumentSnapshot])
    func updateView(basedOn segmentedControlIndex: Int)
}

protocol FinancialAdministratorHistoryViewProtocol: AnyObject {
    func updateView(with model: [FinancialAdministratorHistoryViewModel])
    func updateView(basedOn segmentedControlIndex: Int)
}

final class FinancialAdministratorHistoryPresenter: FinancialAdministratorHistoryPresenterProtocol {
    
    weak var view: FinancialAdministratorHistoryViewProtocol?
    
    func updateView(credit: [DocumentSnapshot], debit: [DocumentSnapshot]) {
        view?.updateView(with: parseApiModelIntoViewModel(credit: credit, debit: debit))
    }
    
    func updateView(basedOn segmentedControlIndex: Int) {
        view?.updateView(basedOn: segmentedControlIndex)
    }
    
    //MARK: Private methods
    private func parseApiModelIntoViewModel(
        credit: [DocumentSnapshot],
        debit: [DocumentSnapshot]) -> [FinancialAdministratorHistoryViewModel] {
            var items: [FinancialAdministratorHistoryViewModel] = []
            
            credit.enumerated().forEach { (index, item) in
                items.append(FinancialAdministratorHistoryViewModel(
                    date: Date.parseData(item["date"] as? String ?? ""),
                    dayBalance: String(item["balance"] as? Float ?? 0.0),
                    name: item["eventName"] as? String ?? "",
                    operationValue: item["eventValue"] as? String ?? "",
                    operatioType: .credit,
                    currentIndex: index+1,
                    total: credit.count))
            }
            
            debit.enumerated().forEach { (index, item) in
                items.append(FinancialAdministratorHistoryViewModel(
                    date: Date.parseData(item["date"] as? String ?? ""),
                    dayBalance: String(item["balance"] as? Float ?? 0.0),
                    name: item["eventName"] as? String ?? "",
                    operationValue: item["eventValue"] as? String ?? "",
                    operatioType: .debit,
                    currentIndex: index+1,
                    total: credit.count))
            }
            
            return items
        }
    
}
