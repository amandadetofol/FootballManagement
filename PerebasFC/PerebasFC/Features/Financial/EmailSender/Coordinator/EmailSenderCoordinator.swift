//
//  EmailSenderCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 20/10/23.
//

import UIKit

protocol EmailSenderCoordinatorProtocol {
    func showEmailUnavailableAlert()
    func showErrorAlert()
    func showSuccessAlert()
    func showMailView(controller: UIViewController)
    func popEmailView(controller: UIViewController)
}

final class EmailSenderCoordinator: EmailSenderCoordinatorProtocol {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func showEmailUnavailableAlert(){
        let alert = UIAlertController(
            title: "Algo deu errado!",
            message: "Para enviar uma notificação por e-mail, é preciso ter uma conta vinculada ao seu ID da Apple.",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: UIAlertAction.Style.default,
                handler: { [weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                }))
        navigationController?.present(
            alert,
            animated: true)
    }
    
    func showErrorAlert(){
        let alert = UIAlertController(
            title: "Algo deu errado!",
            message: "Não foi possível enviar o e-mail! Tente novamente. ",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: UIAlertAction.Style.default,
                handler: { [weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                }))
        navigationController?.present(
            alert,
            animated: true)
    }
    
    func showSuccessAlert(){
        let alert = UIAlertController(
            title: "E-mail enviado!",
            message: "O e-mail foi enviado com sucesso!",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: UIAlertAction.Style.default,
                handler: { [weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                }))
        navigationController?.present(
            alert,
            animated: true)
    }
    
    func showMailView(controller: UIViewController){
        navigationController?.present(controller, animated: true)
    }
    
    func popEmailView(controller: UIViewController){
        controller.navigationController?.popViewController(animated: true)
    }
    
}
