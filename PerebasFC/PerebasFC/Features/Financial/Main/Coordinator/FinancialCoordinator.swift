//
//  FinancialCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 12/06/23.
//

import UIKit

protocol FinancialCoordinatorProtocol {
    func gotoFinancialDetails(with model: FinancialPendencieCardViewModel)
}

final class FinancialCoordinator: FinancialCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func gotoFinancialDetails(with model: FinancialPendencieCardViewModel){
        //TODO: Implementar quando a tela de detalhes estiver pronta 
    }
    
}
