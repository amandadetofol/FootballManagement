//
//  ParticipantsSelectorListViewFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 04/09/23.
//

import UIKit

struct ParticipantsSelectorListViewFactory {
    
    static func getParticipantsSelectorListViewController(navigationController: UINavigationController) -> ParticipantsSelectorListViewController {
        let coordinator = ParticipantsSelectorListViewCoordinator(navigationController: navigationController)
        let presenter = ParticipantsSelectorListViewPresenter()
        let worker = ParticipantsSelectorListViewWorker()
        let interactor = ParticipantsSelectorListViewInteractor(
            worker: worker,
            coordinator: coordinator,
            presenter: presenter)
        let viewController = ParticipantsSelectorListViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}
