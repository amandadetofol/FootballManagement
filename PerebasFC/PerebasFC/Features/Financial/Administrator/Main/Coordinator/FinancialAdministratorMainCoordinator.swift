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
            return
        case .pendencies:
            return
        case .newCredit:
            return
        case .newDebit:
            return
        }
    }
    
}
