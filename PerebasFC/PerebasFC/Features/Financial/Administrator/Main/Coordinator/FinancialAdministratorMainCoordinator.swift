//
//  FinancialAdministratorMainCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 14/08/23.
//

import UIKit

protocol FinancialAdministratorMainCoordinatorProtocol {
    func handleTitleAndDescriptionCardViewTap(model: FinancialAdministratorActions)
}

final class FinancialAdministratorMainCoordinator: FinancialAdministratorMainCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func handleTitleAndDescriptionCardViewTap(model: FinancialAdministratorActions) {
        switch model {
        case .history:
            self.navigationController.pushViewController(
                FinancialAdministratorHistoryFactory.getFinancialAdministratorHistoryViewController(),
                animated: true)
            
        case .pendencies:
            self.navigationController.pushViewController(
                AdministratorPendenciesFactory.getAdministratorPendenciesViewController(
                    navigationController: navigationController),
                animated: true)
            
        case .newCredit:
            self.navigationController.pushViewController(
                NewItemFactory.getNewItemFactory(
                    navigationController: navigationController,
                    type: .credit),
                animated: true)
            
        case .newDebit:
            self.navigationController.pushViewController(
                NewItemFactory.getNewItemFactory(
                    navigationController: navigationController,
                    type: .debit),
                animated: true)
        }
    }
    
}