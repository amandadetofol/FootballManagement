//
//  AdministratorPendenciesCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 19/08/23.
//

import UIKit

protocol AdministratorPendenciesCoordinatorProtocol {
    func goToFinancialAdministratorPendenciesDetails(model: FinancialAdministratorPendenciesListCardModel)
}

final class AdministratorPendenciesCoordinator: AdministratorPendenciesCoordinatorProtocol {
   
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func goToFinancialAdministratorPendenciesDetails(model: FinancialAdministratorPendenciesListCardModel) {
        //TODO: Implementar quando a tela de detalhes for criada
    }
    
}
