//
//  AdministratorPendenciesDetailsFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 19/08/23.
//

import Foundation

struct AdministratorPendenciesDetailsFactory {
    
    static func getAdministratorPendenciesDetailsViewController(model: FinancialAdministratorPendenciesListCardModel) -> AdministratorPendenciesDetailsViewController {
        let worker = AdministratorPendenciesDetailsNotificationWorker()
        let presenter = AdministratorPendenciesDetailsPresenter()
        let coordinator = AdministratorPendenciesDetailsCoordinator()
        let interactor = AdministratorPendenciesDetailsInteractor(
            coordinator: coordinator,
            presenter: presenter,
            model: model,
            worker: worker)
        let viewController = AdministratorPendenciesDetailsViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}
