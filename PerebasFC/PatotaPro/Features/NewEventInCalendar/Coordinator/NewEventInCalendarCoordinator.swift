//
//  NewEventInCalendarCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/07/23.
//

import UIKit

protocol NewEventInCalendarCoordinatorProtocol {
    func showErrorPopUp()
    func showSuccessPopUp()
    func dissmissToBegin()
}

final class NewEventInCalendarCoordinator: NewEventInCalendarCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func showSuccessPopUp(){
        let alert = UIAlertController(
            title: "Evento adicionado!",
            message: "Novo evento adicionado com sucesso. Confira no calendário. ;)",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default,
                handler: { [weak self] _ in
                    
                    guard let self else { return }
                    
                    if let viewController = navigationController.viewControllers.first(where: { $0.isKind(of: HomeViewController.self) }) {
                        guard let vc = viewController as? HomeViewController else { return }
                        navigationController.popToViewController(vc, animated: true)
                    }
    
                }))
        
        navigationController.present(
            alert,
            animated: true)
    }
    
    func showErrorPopUp() {
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
    
    func dissmissToBegin() {
        navigationController.popToRootViewController(animated: true)
    }

}
