//
//  FinancialDetailsFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 13/06/23.
//

import UIKit

final class FinancialDetailsFactory {
    
    static func getFinancialDetailsViewController(
        model: FinancialDetailsViewModel,
        navigationController: UINavigationController) -> FinancialDetailsViewController {
            let presenter = FinancialDetailsPresenter()
            let coordinator = FinancialDetailsCoordinator(navigationController: navigationController)
            let worker = FinancialCommonDetailsWorker()
            let interactor = FinancialDetailsInteractor(
                financialDetailsViewModel: model,
                presenter: presenter,
                worker: worker,
                coordinator: coordinator)
            let viewController = FinancialDetailsViewController(interactor: interactor)
            presenter.view = viewController
            
            return viewController
        }
    
}
