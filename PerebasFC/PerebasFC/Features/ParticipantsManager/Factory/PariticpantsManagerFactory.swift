//
//  PariticpantsManagerFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/08/23.
//

import UIKit

struct PariticpantsManagerFactory {
    
    static func getParticipantsViewController(navigationController: UINavigationController) -> ParticipantsManagerViewController {
        let presenter = ParticipantsManagerPresenter()
        let worker = ParticipantsManagerWorker()
        let coordinator = ParticipantsManagerCoordinator(naviagationController: navigationController)
        let interactor = ParticipantsManagerInteractor(
            worker: worker,
            presenter: presenter,
            coordinator: coordinator)
        let viewController = ParticipantsManagerViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}
