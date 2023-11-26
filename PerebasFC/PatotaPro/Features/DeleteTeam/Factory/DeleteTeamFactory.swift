//
//  DeleteTeamFactory.swift
//  PatotaPro
//
//  Created by Amanda Detofol on 26/11/23.
//

import UIKit

struct DeleteTeamFactory {
    
    static func getDeleteTeamViewController(navigationController: UINavigationController) -> DeleteTeamViewController {
        let worker = DeleteTeamWorker()
        let presenter = DeleteTeamPresenter()
        let coordinator = DeleteTeamCoordinator(navigationController: navigationController)
        let interactor = DeleteTeamInteractor(
            worker: worker,
            presenter: presenter,
            coordinator: coordinator)
        let viewController = DeleteTeamViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}

