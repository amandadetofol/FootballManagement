//
//  PresenceFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/09/23.
//

import UIKit

struct PresenceFactory {
    
    static func getPresenceViewController(navigationController: UINavigationController) -> PresenceViewController {
        let coordinator = PresenceCoordinator(navigationController: navigationController)
        let presenter = PresencePresenter()
        let worker = PresenceWorker()
        let interactor = PresenceInteractor(
            presenter: presenter,
            worker: worker,
            coordinator: coordinator)
        let viewController = PresenceViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}