//
//  PersonalInformationsCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import UIKit

protocol PersonalInformationsCoordinatorProtocol {
    func showErrorMessageAlert()
    func showDeleteUserConfirmationModal(
        userName: String,
        confirmationAction: @escaping(()->Void))
    func goToBack()
    func handleGoToChangePasswordFlow()
}

final class PersonalInformationsCoordinator: PersonalInformationsCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
    
    func showDeleteUserConfirmationModal(
        userName: String,
        confirmationAction: @escaping(()->Void)) {
            let alert = UIAlertController(
                title: "Atenção",
                message: "Tem certeza que deseja excluir \(userName)?",
                preferredStyle: UIAlertController.Style.alert)
            alert.addAction(
                UIAlertAction(
                    title: "Continuar",
                    style: .default,
                    handler: {  _ in
                        confirmationAction()
                    }))
            alert.addAction(
                UIAlertAction(
                    title: "Cancelar",
                    style: .destructive,
                    handler: { [weak self] _ in
                        self?.navigationController.popViewController(animated: true)
                    }))
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
    
}
