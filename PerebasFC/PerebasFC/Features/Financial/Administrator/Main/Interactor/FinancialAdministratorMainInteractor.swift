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
    private let model: FinancialAdministratorMainViewModel
    
    init(presenter: FinancialAdministratorMainPresenterProtocol,
         coordinator: FinancialAdministratorMainCoordinatorProtocol,
         model: FinancialAdministratorMainViewModel) {
        self.presenter = presenter
        self.model = model
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        presenter.updateView(with: model)
    }
    
    func handleTitleAndDescriptionCardViewTap(model: FinancialAdministratorActions) {
        coordinator.handleTitleAndDescriptionCardViewTap(model: model)
    }
    
}
