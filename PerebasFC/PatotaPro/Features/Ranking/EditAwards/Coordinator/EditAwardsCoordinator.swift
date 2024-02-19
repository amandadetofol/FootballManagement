//
//  EditAwardsCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 15/06/23.
//

import UIKit

protocol EditAwardsCoordinatorProtocol {
    func goToBack()
    func showLoading(_ completion: @escaping(()->Void))
    func removeLoading(_ completion: @escaping(()->Void))
    func showSuccessAlert()
    func showErrorAlert()
}

final class EditAwardsCoordinator: EditAwardsCoordinatorProtocol {
    
    private let loader: LoaderCoodinator
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.loader = LoaderCoodinator(navigationController: navigationController)
    }
    
    func goToBack() {
        navigationController.popViewController(animated: true)
    }
    
    func showLoading(_ completion: @escaping(()->Void)){
        loader.showLoader(completion)
    }
    
    func removeLoading(_ completion: @escaping(()->Void)){
        loader.removeLoader(completion)
    }
    
    func showSuccessAlert(){
        let alert = UIAlertController(
            title: "Premios atualizados com sucesso!",
            message: "Clique em OK para ir para tela anterior.",
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
    
    func showErrorAlert(){
        let alert = UIAlertController(
            title: "Ops! Algo deu errado :(",
            message: "Tente novamente.",
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
