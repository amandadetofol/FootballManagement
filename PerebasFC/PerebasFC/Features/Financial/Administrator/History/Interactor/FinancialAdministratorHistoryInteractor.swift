//
//  FinancialAdministratorHistoryInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 21/08/23.
//

import UIKit

final class FinancialAdministratorHistoryInteractor: FinancialAdministratorHistoryInteractorProtocol {

    private let worker: FinancialAdministratorHistoryWorkerProtocol
    private let presenter: FinancialAdministratorHistoryPresenterProtocol
    
    init(worker: FinancialAdministratorHistoryWorkerProtocol,
         presenter: FinancialAdministratorHistoryPresenterProtocol){
        self.presenter = presenter
        self.worker = worker 
    }
    
    func viewDidLoad() {
        worker.getFinancialHistory { [weak self ] viewModel in
            guard let self = self else { return }
            self.presenter.updateView(with: viewModel)
        }
    }
    
    func updateView(basedOn segmentedControlIndex: Int) {
        presenter.updateView(basedOn: segmentedControlIndex)
    }
    
}
