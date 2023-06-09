//
//  ChatMainCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 09/06/23.
//

import UIKit

protocol ChatMainCoordinatorProtocol {
    func goToChatDetails(model: [Chat])
    func showErrorAlertView()
}

final class ChatMainCoordinator: ChatMainCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func goToChatDetails(model: [Chat]) {
        //TODO: Implementar
    }
    
    func showErrorAlertView() {
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
    
}
