//
//  AdministratorPendenciesDetailsFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 19/08/23.
//

import UIKit

struct AdministratorPendenciesDetailsFactory {
    
    static func getAdministratorPendenciesDetailsViewController(
        model: FinancialAdministratorPendenciesListCardModel,
        navigationController: UINavigationController) -> AdministratorPendenciesDetailsViewController {
            let worker = AdministratorPendenciesDetailsNotificationWorker()
            let presenter = AdministratorPendenciesDetailsPresenter()
            let coordinator = AdministratorPendenciesDetailsCoordinator(navigationController: navigationController)
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
