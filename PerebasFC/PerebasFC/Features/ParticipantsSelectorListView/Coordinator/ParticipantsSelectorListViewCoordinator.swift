//
//  ParticipantsSelectorListViewCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 04/09/23.
//

import UIKit

protocol ParticipantsSelectorListViewCoordinatorProtocol {
    func showErrorAlert()
    func dissmissToDebitViewWithSelectedUser(name: String)
}

final class ParticipantsSelectorListViewCoordinator: ParticipantsSelectorListViewCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func dissmissToDebitViewWithSelectedUser(name: String) {
        if let viewController = navigationController.viewControllers.last(where: { $0.isKind(of: NewItemViewController.self) }) {
            guard let vc = viewController as? NewItemViewController else { return }
            vc.name = name 
            navigationController.popToViewController(vc, animated: true)
        }

    }
    
    func showErrorAlert() {
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
