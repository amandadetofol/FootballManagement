//
//  SignUpCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 11/09/23.
//

import UIKit

protocol SignUpCoordinatorProtocol {
    func showAlert(succeded: Bool)
    func showLoading()
    func removeLoading()
}

final class SignUpCoordinator: SignUpCoordinatorProtocol {
    
    private let loading: LoaderCoodinator
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.loading = LoaderCoodinator(navigationController: navigationController)
    }
    
    func showAlert(succeded: Bool) {
        if succeded {
            showSuccessAlert()
        } else {
            showErrorAlert()
        }
    }
    
    private func showSuccessAlert(){
        let alert = UIAlertController(
            title: "Usuário adicionado com sucesso!",
            message: "Vá para o login para acessar o aplicativo.",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: UIAlertAction.Style.default,
                handler: { [weak self] _ in
                    self?.navigationController.popViewController(animated: true)
                }))
        navigationController.present(
            alert,
            animated: true)
    }
    
    private func showErrorAlert(){
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
    
    func showLoading(){
        loading.showLoader()
    }
    
    func removeLoading(){
        loading.removeLoader()
    }
    
}
