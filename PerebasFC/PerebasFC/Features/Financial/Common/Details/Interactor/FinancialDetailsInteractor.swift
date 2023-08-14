//
//  FinancialDetailsInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 13/06/23.
//

import Foundation

protocol FinancialDetailsPresenterProtocol {
    func updateView(with model: FinancialDetailsViewModel)
    func handleAddProofButtonTap()
}

final class FinancialDetailsInteractor: FinancialDetailsInteractorProtocol {
 
    private let financialDetailsViewModel: FinancialDetailsViewModel
    private let presenter: FinancialDetailsPresenterProtocol
    
    init(financialDetailsViewModel: FinancialDetailsViewModel,
         presenter: FinancialDetailsPresenterProtocol) {
        self.financialDetailsViewModel = financialDetailsViewModel
        self.presenter = presenter
    }
 
    func viewDidLoad() {
        presenter.updateView(with: financialDetailsViewModel)
    }
    
    func handleAddProofButtonTap() {
        presenter.handleAddProofButtonTap()
    }
    
}
