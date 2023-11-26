//
//  DeleteTeamCoordinator.swift
//  PatotaPro
//
//  Created by Amanda Detofol on 26/11/23.
//

import UIKit

protocol DeleteTeamCoordinatorProtocol {
    func showErrorMessage()
    func showSuccessMessage()
    func showLoading()
    func removerLoading()
}

final class DeleteTeamCoordinator: DeleteTeamCoordinatorProtocol {
    
    private weak var navigationController: UINavigationController?
    private let loader: LoaderCoodinatorProtocol
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.loader = LoaderCoodinator(navigationController: navigationController)
    }
    
    func showErrorMessage() {
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
    
    func showSuccessMessage() {
        let alert = UIAlertController(
            title: "Patota excluída com sucesso.",
            message: "Você será redirecionado para a tela inicial do aplicativo.",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: .default,
                handler: { _ in
                    self.navigationController?.popToRootViewController(animated: true)
                }))
        navigationController?.present(
            alert,
            animated: true)
    }
    
    func showLoading(){
        loader.showLoader()
    }
    
    func removerLoading(){
        loader.removeLoader()
    }

}
