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
    private let coordinator: FinancialAdministratorHistoryCoordinatorProtocol
    
    init(worker: FinancialAdministratorHistoryWorkerProtocol,
         coordinator: FinancialAdministratorHistoryCoordinatorProtocol,
         presenter: FinancialAdministratorHistoryPresenterProtocol){
        self.presenter = presenter
        self.worker = worker
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        coordinator.showLoading { [weak self]  in
            guard let self else { return }
            worker.getFinancialHistory { credit, debit in
                guard let credit,
                      let debit else {
                    self.coordinator.removeLoading {
                        self.coordinator.showErrorAlertView()
                    }
                    return
                }
                self.coordinator.removeLoading {
                    self.presenter.updateView(credit: credit, debit: debit)
                }
            }
        }
    }
    
    func updateView(basedOn segmentedControlIndex: Int) {
        presenter.updateView(basedOn: segmentedControlIndex)
    }
    
}
