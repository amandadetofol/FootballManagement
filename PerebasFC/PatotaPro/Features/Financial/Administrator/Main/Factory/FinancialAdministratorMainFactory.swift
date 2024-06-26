//
//  FinancialAdministratorMainFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 14/08/23.
//

import UIKit

struct FinancialAdministratorMainFactory {
    
    static func getFinancialAdministratorMainViewController(
        navigationController: UINavigationController,
        model: FinancialAdministratorMainViewModel) -> FinancialAdministratorMainViewController {
            let worker = FinancialAdministratorMainWorker()
            let coordinator = FinancialAdministratorMainCoordinator(navigationController: navigationController)
            let presenter = FinancialAdministratorMainPresenter()
            let interactor = FinancialAdministratorMainInteractor(
                presenter: presenter,
                coordinator: coordinator,
                worker: worker,
                model: model)
            let viewController = FinancialAdministratorMainViewController(interactor: interactor)
            presenter.view = viewController
            
            return viewController
        }
    
}
