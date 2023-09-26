//
//  PersonalInformationsFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import UIKit

final class PersonalInformationsFactory {
    
    static func getPersonalInformationsViewController(
        navigationController: UINavigationController,
        email: String? = nil) -> PersonalInformationsViewController {
            let coordinator = PersonalInformationsCoordinator(navigationController: navigationController)
            let presenter = PersonalInformationsPresenter()
            let worker = PersonalInformationsWorker()
            let interactor = PersonalInformationsInteractor(
                coordinator: coordinator,
                presenter: presenter,
                worker: worker)
            interactor.email = email
            let viewController = PersonalInformationsViewController(interactor: interactor)
            presenter.view = viewController
            
            return viewController
        }
    
}
