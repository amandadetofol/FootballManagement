//
//  AdministratorPendenciesDetailsCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 19/08/23.
//

import UIKit

protocol AdministratorPendenciesDetailsCoordinatorProtocol {
    func openUrl(url: String?)
    func showLoading()
    func removeLoading()
    func showErrorAlert()
    func showSuccessAlert()
}

final class AdministratorPendenciesDetailsCoordinator: AdministratorPendenciesDetailsCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    private let loader: LoaderCoodinator
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.loader = LoaderCoodinator(navigationController: navigationController)
    }
    
    func openUrl(url: String?) {
        guard let url = url,
              let urlString = URL(string: url) else { return }
        UIApplication.shared.openURL(urlString)
    }
    
    func showLoading(){
        loader.showLoader()
    }
    
    func removeLoading(){
        loader.removeLoader()
    }
    
    func showErrorAlert(){
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
    
    func showSuccessAlert(){
        let alert = UIAlertController(
            title: "Informações atualizadas com sucesso.",
            message: "",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: UIAlertAction.Style.default,
                handler: { _ in
                    self.navigationController.popViewController(animated: true)
                }))
        navigationController.present(
            alert,
            animated: true)
    }
    
}
