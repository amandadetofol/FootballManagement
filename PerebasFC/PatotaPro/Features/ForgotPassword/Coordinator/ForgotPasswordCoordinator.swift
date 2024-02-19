//
//  ForgotPasswordCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 22/05/23.
//

import UIKit

protocol ForgotPasswordCoordinatorProtocol {
    func goToShowSendResetLinkAlert(email: String)
    func goToShowSendResetErrorAlert()
    func showLoading(_ completion: @escaping(()->Void))
    func removeLoading(_ completion: @escaping(()->Void))
}

final class ForgotPasswordCoordinator: ForgotPasswordCoordinatorProtocol {
 
    private let loader: LoaderCoodinator
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.loader = LoaderCoodinator(navigationController: navigationController)
    }
    
    func goToShowSendResetLinkAlert(email: String) {
        let alert = UIAlertController(
             title: "E-mail enviado ;)",
             message: "Enviamos um link para o e-mail \(email) para realizar a troca de senha.",
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
    
    func goToShowSendResetErrorAlert() {
       let alert = UIAlertController(
            title: "Ops!",
            message: "Algo deu errado :( \n Revise seu e-mail e tente novamente!",
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
    
    func showLoading(_ completion: @escaping(()->Void)) {
        loader.showLoader(completion)
    }
    
    func removeLoading(_ completion: @escaping(()->Void)){
        loader.removeLoader(completion)
    }
   
}
