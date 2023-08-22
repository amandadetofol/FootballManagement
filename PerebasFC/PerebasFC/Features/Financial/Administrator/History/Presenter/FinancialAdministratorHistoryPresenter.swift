//
//  FinancialAdministratorHistoryPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 21/08/23.
//

import Foundation

protocol FinancialAdministratorHistoryPresenterProtocol {
    func updateView(with model: [FinancialAdministratorHistoryViewModel])
    func updateView(basedOn segmentedControlIndex: Int)
}

protocol FinancialAdministratorHistoryViewProtocol: AnyObject {
    func updateView(with model: [FinancialAdministratorHistoryViewModel])
    func updateView(basedOn segmentedControlIndex: Int)
}

final class FinancialAdministratorHistoryPresenter: FinancialAdministratorHistoryPresenterProtocol {
    
    weak var view: FinancialAdministratorHistoryViewProtocol?
    
    func updateView(with model: [FinancialAdministratorHistoryViewModel]) {
        view?.updateView(with: model)
    }
    
    func updateView(basedOn segmentedControlIndex: Int) {
        view?.updateView(basedOn: segmentedControlIndex)
    }
    
}
