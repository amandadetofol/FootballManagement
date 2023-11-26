//
//  SignUpFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 11/09/23.
//

import UIKit

struct SignUpFactory {
    
    static func getSignUpViewController(navigationController: UINavigationController) -> SignUpViewController {
        let coordinator = SignUpCoordinator(navigationController: navigationController)
        let presenter = SignUpPresenter()
        let worker = SignUpWorker()
        let interactor = SignUpInteractor(
            worker: worker,
            presenter: presenter,
            coordinator: coordinator)
        let controller = SignUpViewController(interactor: interactor)
        presenter.view = controller
        
        return controller
    }
    
}
