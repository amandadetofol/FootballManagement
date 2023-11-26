//
//  FinancialAdministratorDetailsCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 14/09/23.
//

import UIKit

protocol FinancialDetailsCoordinatorProtocol {
    func showLoading()
    func removeLoading()
    func showUploadSuccessAlert()
    func showUploadErrorAlert()
}

final class FinancialDetailsCoordinator: FinancialDetailsCoordinatorProtocol {
    
    private let loader: LoaderCoodinator
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.loader = LoaderCoodinator(navigationController: navigationController)
    }

    func showLoading(){
        loader.showLoader()
    }
    
    func removeLoading(){
        loader.removeLoader()
    }
    
    func showUploadSuccessAlert(){
        let alert = UIAlertController(
            title: "Comprovante anexado com sucesso.",
            message: "O item ainda ficará na aba Pendências até que o administrador visualize o comprovante.",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: UIAlertAction.Style.default,
                handler: { [weak self] _ in
                    guard let self else { return }
                    self.goToHome()
                }))
        navigationController.present(
            alert,
            animated: true)
    }
    
    func showUploadErrorAlert(){
        let alert = UIAlertController(
            title: "Ops! Algo deu errado.",
            message: "Tente novamente",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: UIAlertAction.Style.default,
                handler: { [weak self] _ in
                    guard let self else { return }
                    self.goToHome()
                }))
        navigationController.present(
            alert,
            animated: true)
    }
    
    //MARK: Private methods
    private func goToHome(){
        if let viewController = navigationController.viewControllers.last(where: { $0.isKind(of: HomeViewController.self) }) {
            guard let vc = viewController as? HomeViewController else { return }
            navigationController.popToViewController(vc, animated: true)
        }
    }

}
