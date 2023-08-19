//
//  AdministratorPendenciesInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 19/08/23.
//

import Foundation

final class AdministratorPendenciesInteractor: AdministratorPendenciesInteractorProtocol {
    
    private let worker: AdministratorPendenciesWorkerProtocol
    private let coordinator: AdministratorPendenciesCoordinatorProtocol
    private let presenter: FinancialAdministratorPresenterProtocol
    
    init(worker: AdministratorPendenciesWorkerProtocol,
         coordinator: AdministratorPendenciesCoordinatorProtocol,
         presenter: FinancialAdministratorPresenterProtocol) {
        self.worker = worker
        self.presenter = presenter
        self.coordinator = coordinator
    }
  
    func viewDidLoad() {
        worker.getUsersPendencies { [weak self] model in
            self?.presenter.updateView(with: model)
        }
    }
    
    func handleTitleAndDescriptionCardViewTap(model: FinancialAdministratorPendenciesListCardModel) {
        coordinator.goToFinancialAdministratorPendenciesDetails(model: model)
    }
    
    func updateView(basedOn segmentedControlIndex: Int) {
        presenter.updateView(basedOn: segmentedControlIndex)
    }
    
}
