//
//  FinancialAdministratorHistoryFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 21/08/23.
//

import UIKit

struct FinancialAdministratorHistoryFactory {
    
    static func getFinancialAdministratorHistoryViewController(navigationController: UINavigationController) -> FinancialAdministratorHistoryViewController {
        let presenter = FinancialAdministratorHistoryPresenter()
        let worker = FinancialAdministratorHistoryWorker()
        let coordinator = FinancialAdministratorHistoryCoordinator(navigationController: navigationController)
        let interactor = FinancialAdministratorHistoryInteractor(
            worker: worker,
            coordinator: coordinator,
            presenter: presenter)
        let viewController = FinancialAdministratorHistoryViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}
