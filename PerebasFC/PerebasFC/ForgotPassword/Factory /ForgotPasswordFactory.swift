//
//  ForgotPasswordFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 22/05/23.
//

import UIKit

final class ForgotPasswordFactory {
    
    static func getForgotPasswordViewController(
        navigationController: UINavigationController,
        email: String) -> ForgotPasswordViewController {
            let worker = ForgotPasswordWorker()
            let presenter = ForgotPasswordPresenter()
            let coordinator = ForgotPasswordCoordinator(navigationController: navigationController)
            let interactor = ForgotPasswordInteractor(
                worker: worker,
                coordinator: coordinator,
                presenter: presenter,
                email: email)
            let viewController = ForgotPasswordViewController(interactor: interactor)
            presenter.view = viewController
            
            return viewController
    }
    
}
