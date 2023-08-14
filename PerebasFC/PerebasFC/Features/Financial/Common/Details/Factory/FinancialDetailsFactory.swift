//
//  FinancialDetailsFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 13/06/23.
//

import UIKit

final class FinancialDetailsFactory {
    
    static func getFinancialDetailsViewController(model: FinancialDetailsViewModel) -> FinancialDetailsViewController {
        let presenter = FinancialDetailsPresenter()
        let interactor = FinancialDetailsInteractor(
            financialDetailsViewModel: model,
            presenter: presenter)
        let viewController = FinancialDetailsViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}
