//
//  FinancialAdministratorHistoryFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 21/08/23.
//

import UIKit

struct FinancialAdministratorHistoryFactory {
    
    static func getFinancialAdministratorHistoryViewController() -> FinancialAdministratorHistoryViewController {
        let presenter = FinancialAdministratorHistoryPresenter()
        let worker = FinancialAdministratorHistoryWorker()
        let interactor = FinancialAdministratorHistoryInteractor(
            worker: worker,
            presenter: presenter)
        let viewController = FinancialAdministratorHistoryViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}
