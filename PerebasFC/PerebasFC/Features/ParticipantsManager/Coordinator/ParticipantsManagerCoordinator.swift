//
//  ParticipantsManagerCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/08/23.
//

import UIKit

protocol ParticipantsManagerCoordinatorProtocol{
    func openPersonalInformationsView(user: User)
    func showLoading()
    func removeLoading()
    func showErrorAlert()
}

final class ParticipantsManagerCoordinator: ParticipantsManagerCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    private let loader: LoaderCoodinator
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.loader = LoaderCoodinator(navigationController: navigationController)
    }
   
    func openPersonalInformationsView(user: User) {
        navigationController.pushViewController(
            PersonalInformationsFactory.getPersonalInformationsViewController(
                navigationController: navigationController),
            animated: true)
    }
    
    func showLoading(){
        loader.showLoader()
    }
    
    func removeLoading(){
        loader.removeLoader()
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
