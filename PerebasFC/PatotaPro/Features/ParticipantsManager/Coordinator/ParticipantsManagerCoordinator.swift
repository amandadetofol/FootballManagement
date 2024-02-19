//
//  ParticipantsManagerCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/08/23.
//

import UIKit

protocol ParticipantsManagerCoordinatorProtocol{
    func openPersonalInformationsView(email: String)
    func showLoading(_ completion: @escaping(()->Void))
    func removeLoading(_ completion: @escaping(()->Void))
    func showErrorAlert()
}

final class ParticipantsManagerCoordinator: ParticipantsManagerCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    private let loader: LoaderCoodinator
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.loader = LoaderCoodinator(navigationController: navigationController)
    }
   
    func openPersonalInformationsView(email: String) {
        navigationController.pushViewController(
            PersonalInformationsFactory.getPersonalInformationsViewController(
                navigationController: navigationController,
                email: email),
            animated: true)
    }
    
    func showLoading(_ completion: @escaping(()->Void)){
        loader.showLoader(completion)
    }
    
    func removeLoading(_ completion: @escaping(()->Void)){
        loader.removeLoader(completion)
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
