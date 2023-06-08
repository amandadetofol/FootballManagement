//
//  ChangePasswordCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/06/23.
//

import UIKit

protocol ChangePasswordCoordinatorProtocol {
    func showErrorAlertMessage()
    func showSuccessAlertMessage()
}

final class ChangePasswordCoordinator: ChangePasswordCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func showErrorAlertMessage(){
        let alert = UIAlertController(
            title: "Ops!",
            message: "Algo deu errado :( ",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default,
                handler: { [weak self] _ in
                    self?.navigationController.popViewController(animated: true)
                }))
        navigationController.present(
            alert,
            animated: true)
    }
    
    func showSuccessAlertMessage(){
        let alert = UIAlertController(
            title: "Senha alterada com sucesso!",
            message: "Sua senha foi alterada com sucesso!",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default,
                handler: { [weak self] _ in
                    self?.navigationController.popViewController(animated: true)
                }))
        navigationController.present(
            alert,
            animated: true)
    }
}
