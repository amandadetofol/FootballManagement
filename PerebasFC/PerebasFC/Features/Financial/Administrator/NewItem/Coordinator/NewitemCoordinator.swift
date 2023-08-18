//
//  NewitemCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 17/08/23.
//

import UIKit

protocol NewItemCoordinatorProtocol {
    func showSuccessFeedback()
    func showErrorFeedback()
}

final class NewItemCoordinator: NewItemCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showSuccessFeedback(){
        let alert = UIAlertController(
            title: "Novo item adicionado com sucesso!",
            message: "Confira o novo item adicionado na tela de histórico.",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: { [weak self] _ in
                    guard let self = self else { return }
                    self.navigationController.popViewController(animated: true)
                }))
        navigationController.present(
            alert,
            animated: true)
    }
    
    func showErrorFeedback(){
        let alert = UIAlertController(
            title: "Ops!",
            message: "Algo deu errado :( \n Por favor, tente novamente.",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: { [weak self] _ in
                    guard let self = self else { return }
                    self.navigationController.popViewController(animated: true)
                }))
        navigationController.present(
            alert,
            animated: true)
    }
    
}
