//
//  FinancialAdministratorMainInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 14/08/23.
//

import Foundation

final class FinancialAdministratorMainInteractor: FinancialAdministratorMainInteractorProtocol {
    
    private let presenter: FinancialAdministratorMainPresenterProtocol
    private let coordinator: FinancialAdministratorMainCoordinatorProtocol
    private let worker: FinancialAdministratorMainWorkerProtocol
    private var model: FinancialAdministratorMainViewModel
    
    init(presenter: FinancialAdministratorMainPresenterProtocol,
         coordinator: FinancialAdministratorMainCoordinatorProtocol,
         worker: FinancialAdministratorMainWorkerProtocol,
         model: FinancialAdministratorMainViewModel) {
        self.presenter = presenter
        self.model = model
        self.coordinator = coordinator
        self.worker = worker
    }
    
    func viewDidLoad() {
        coordinator.showLoading()
        worker.getCurrentBalance { [weak self] document in
            guard let self,
                  let document else {
                self?.coordinator.removeLoading()
                self?.coordinator.showAlertError()
                return
            }
            
            self.coordinator.removeLoading()
            self.model.username = Session.shared.loggedUserEmail ?? "Administrador"
            self.model.balance = "R$ \(document["balance"] as? Int ?? 0)"
            self.presenter.updateView(with: model)
        }
    }
    
    func handleTitleAndDescriptionCardViewTap(model: FinancialAdministratorActions) {
        coordinator.handleTitleAndDescriptionCardViewTap(model: model)
    }
    
}
