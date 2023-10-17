//
//  FinancialAdministratorHistoryCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 17/10/23.
//

import UIKit

protocol FinancialAdministratorHistoryCoordinatorProtocol {
    func showLoading()
    func removeLoading()
    func showErrorAlertView()
}

final class FinancialAdministratorHistoryCoordinator: FinancialAdministratorHistoryCoordinatorProtocol {
    
    private weak var navigationController: UINavigationController?
    private let loader: LoaderCoodinator
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.loader = LoaderCoodinator(navigationController: navigationController)
    }
    
    func showLoading(){
        loader.showLoader()
    }
    
    func removeLoading() {
        loader.removeLoader()
    }
    
    func showErrorAlertView(){
        let alert = UIAlertController(
            title: "Ops! Algo deu errado :(",
            message: "Tente novamente!",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: UIAlertAction.Style.default))
        navigationController?.present(
            alert,
            animated: true)
    }
    
}
