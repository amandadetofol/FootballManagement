//
//  LoginFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 16/05/23.
//

import UIKit

final class LoginFactory {
    
    static func getLoginViewController(navigationController: UINavigationController) -> LoginViewController {
        let coordinator = LoginCoordinator(navigationController: navigationController)
        let presenter = LoginPresenter()
        let worker = LoginWorker()
        let interactor = LoginInteractor(
            coordinator: coordinator,
            presenter: presenter,
            worker: worker)
        let viewController = LoginViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}
