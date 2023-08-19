//
//  AdministratorPendenciesFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 19/08/23.
//

import UIKit

struct AdministratorPendenciesFactory {
    
    static func getAdministratorPendenciesViewController(navigationController: UINavigationController) -> AdministratorPendenciesViewController {
        let coordinator = AdministratorPendenciesCoordinator(navigationController: navigationController)
        let presenter = AdministratorPendenciesPresenter()
        let worker = AdministratorPendenciesWorker()
        let interactor = AdministratorPendenciesInteractor(
            worker: worker,
            coordinator: coordinator,
            presenter: presenter)
        let viewController = AdministratorPendenciesViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}
