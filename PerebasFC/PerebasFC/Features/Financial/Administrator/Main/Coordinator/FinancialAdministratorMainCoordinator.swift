//
//  FinancialAdministratorMainCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 14/08/23.
//

import UIKit

protocol FinancialAdministratorMainCoordinatorProtocol {
    func showLoading()
    func removeLoading()
    func showAlertError()
    func handleTitleAndDescriptionCardViewTap(model: FinancialAdministratorActions)
}

final class FinancialAdministratorMainCoordinator: FinancialAdministratorMainCoordinatorProtocol {
    
    private let loader: LoaderCoodinator
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.loader = LoaderCoodinator(navigationController: navigationController)
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
                    type: .credit,
                    admtype: .newCredit),
                animated: true)
            
        case .newDebit:
            self.navigationController.pushViewController(
                NewItemFactory.getNewItemFactory(
                    navigationController: navigationController,
                    type: .debit,
                    admtype: .newDebit),
                animated: true)
        }
    }
    
    func showLoading() {
        loader.showLoader()
    }
    
    func removeLoading(){
        loader.removeLoader()
    }
    
    func showAlertError(){
        let alert = UIAlertController(
            title: "Ops! Algo deu errado :(",
            message: "Tente novamente!",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: UIAlertAction.Style.default))
        navigationController.present(
            alert,
            animated: true)
    }
    
}
