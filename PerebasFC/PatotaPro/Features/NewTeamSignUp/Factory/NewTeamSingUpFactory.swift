//
//  NewTeamSingUpFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 04/11/23.
//

import UIKit

struct NewTeamSingUpFactory {
    
    static func getNewTeamSignUpViewController(nagivationController: UINavigationController) -> NewTeamSignUpViewController {
        let presenter = NewTeamSignUpPresenter()
        let coordinator = NewTeamSignUpCoordinator(navigationController: nagivationController)
        let worker = NewTeamSignUpWorker()
        let interactor = NewTeamSignUpInteractor(
            presenter: presenter,
            coordinator: coordinator,
            worker: worker)
        let viewController = NewTeamSignUpViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}
