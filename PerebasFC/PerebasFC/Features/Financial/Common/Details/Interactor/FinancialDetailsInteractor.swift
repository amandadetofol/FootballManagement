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
 
    private let coordinator: FinancialDetailsCoordinatorProtocol
    private let worker: FinancialCommonDetailsWorkerProtocol
    private let financialDetailsViewModel: FinancialDetailsViewModel
    private let presenter: FinancialDetailsPresenterProtocol
    
    init(financialDetailsViewModel: FinancialDetailsViewModel,
         presenter: FinancialDetailsPresenterProtocol,
         worker: FinancialCommonDetailsWorkerProtocol,
         coordinator: FinancialDetailsCoordinatorProtocol) {
        self.financialDetailsViewModel = financialDetailsViewModel
        self.presenter = presenter
        self.worker = worker
        self.coordinator = coordinator
    }
 
    func viewDidLoad() {
        presenter.updateView(with: financialDetailsViewModel)
    }
    
    func handleAddProofButtonTap() {
        presenter.handleAddProofButtonTap()
    }
    
    func addNewProof(itemId: Int, data: Data) {
        coordinator.showLoading()
        worker.addProof(
            itemId: itemId,
            proofData: data) { [weak self] succeded in
                
                guard let self else { return }
                self.coordinator.removeLoading()
                
                if succeded {
                    self.coordinator.showUploadSuccessAlert()
                } else {
                    self.coordinator.showUploadErrorAlert()
                }
            }
    }
    
}
