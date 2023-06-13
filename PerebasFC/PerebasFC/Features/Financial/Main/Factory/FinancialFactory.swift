//
//  FinancialFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 12/06/23.
//

import UIKit

final class FinancialFactory {
    
    static func getFinancialViewController(navigationController: UINavigationController) -> FinancialPendenciesViewController {
        let coordinator = FinancialCoordinator(navigationController: navigationController)
        let presenter = FinancialPresenter()
        let worker = FinancialWorker()
        let interactor = FinancialInteractor(
            presenter: presenter,
            coordinator: coordinator,
            worker: worker)
        let viewController = FinancialPendenciesViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}
