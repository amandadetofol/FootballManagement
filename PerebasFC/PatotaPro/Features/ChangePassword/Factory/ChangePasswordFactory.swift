//
//  ChangePasswordFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/06/23.
//

import UIKit

final class ChangePasswordFactory {
    
    static func getChangePasswordViewController(navigationController: UINavigationController) -> ChangePasswordViewController {
        let coordinator = ChangePasswordCoordinator(navigationController: navigationController)
        let worker = ChangePasswordWorker()
        let presenter = ChangePasswordPresenter()
        let interactor = ChangePasswordInteractor(
            worker: worker,
            coordinator: coordinator,
            presenter: presenter)
        let viewController = ChangePasswordViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}
