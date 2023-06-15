//
//  FinancialDetailsPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 13/06/23.
//

import Foundation

protocol FinancialDetailsViewProtocol: AnyObject {
    func updateView(with model: FinancialDetailsViewModel)
    func showAddNewProofItem()
}

final class FinancialDetailsPresenter: FinancialDetailsPresenterProtocol {
    
    weak var view: FinancialDetailsViewProtocol?
    
    func updateView(with model: FinancialDetailsViewModel) {
        view?.updateView(with: model)
    }
    
    func handleAddProofButtonTap() {
        view?.showAddNewProofItem()
    }
    
}
