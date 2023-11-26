//
//  PersonalInformationsCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import UIKit

protocol PersonalInformationsCoordinatorProtocol {
    func showErrorMessageAlert()
    func goToBack()
    func handleGoToChangePasswordFlow()
    func showLoading()
    func removeLoading()
    func showUpdateSuccessPopUp()
    func showUpdateErrorPopUp()
    func showDeleteUserSuccessPopUp(email: String)
}

final class PersonalInformationsCoordinator: PersonalInformationsCoordinatorProtocol {
    
    private let loader: LoaderCoodinator
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.loader = LoaderCoodinator(navigationController: navigationController)
    }
    
    func showErrorMessageAlert() {
        let alert = UIAlertController(
            title: "Ops!",
            message: "Algo deu errado :( \n Revise seus dados e tente novamente!",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default,
                handler: nil))
        navigationController.present(
            alert,
            animated: true)
    }
    
    func goToBack() {
        self.navigationController.popViewController(animated: true)
    }
    
    func handleGoToChangePasswordFlow() {
        navigationController.pushViewController(
            ChangePasswordFactory.getChangePasswordViewController(
                navigationController: navigationController),
            animated: true)
    }
    
    func showLoading(){
        loader.showLoader()
    }
    
    func removeLoading() {
        loader.removeLoader()
    }
    
    func showUpdateSuccessPopUp(){
        let alert = UIAlertController(
            title: "Dados atualizados!",
            message: "Os dados foram atualizados com sucesso.",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default,
                handler: nil))
        navigationController.present(
            alert,
            animated: true)
    }

    func showUpdateErrorPopUp(){
        let alert = UIAlertController(
            title: "Ops!",
            message: "Algo deu errado :( \n Clique na opção Editar e em seguida em OK para realizar o processo novamente.",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default,
                handler: nil))
        navigationController.present(
            alert,
            animated: true)
    }
    
    func showDeleteUserSuccessPopUp(email: String){
        let alert = UIAlertController(
            title: "Usuário excluído!",
            message: "O usuário \(email) foi excluído com sucesso.",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default,
                handler: { [weak self] _ in
                    self?.navigationController.popToRootViewController(animated: true)
                }))
        navigationController.present(
            alert,
            animated: true)
    }

    
}
