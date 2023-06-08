//
//  PersonalInformationsCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import UIKit

protocol PersonalInformationsCoordinatorProtocol {
    func showErrorMessageAlert()
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
    
    func handleGoToChangePasswordFlow() {
        navigationController.pushViewController(
            ChangePasswordFactory.getChangePasswordViewController(
                navigationController: navigationController),
            animated: true)
    }
    
}
