//
//  AdministratorPendenciesCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 19/08/23.
//

import UIKit

protocol AdministratorPendenciesCoordinatorProtocol {
    func showLoading(_ completion: @escaping(()->Void))
    func removeLoading(_ completion: @escaping(()->Void))
    func showErrorPopUp()
    func goToFinancialAdministratorPendenciesDetails(model: FinancialAdministratorPendenciesListCardModel)
}

final class AdministratorPendenciesCoordinator: AdministratorPendenciesCoordinatorProtocol {
    
    private let loader: LoaderCoodinator
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.loader = LoaderCoodinator(navigationController: navigationController)
    }
    
    func goToFinancialAdministratorPendenciesDetails(model: FinancialAdministratorPendenciesListCardModel) {
        self.navigationController.pushViewController(
            AdministratorPendenciesDetailsFactory
                .getAdministratorPendenciesDetailsViewController(
                    model: model,
                    navigationController: navigationController),
            animated: true)
    }
    
    func showLoading(_ completion: @escaping(()->Void)){
        loader.showLoader(completion)
    }
    
    func removeLoading(_ completion: @escaping(()->Void)){
        loader.removeLoader(completion)
    }
    
    func showErrorPopUp(){
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
