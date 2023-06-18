//
//  EditAwardsFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 18/06/23.
//

import UIKit

final class EditAwardsFactory {
    
    static func getEditAwardsViewController(
        navigationController: UINavigationController,
        model: EditAwardsViewModel) -> EditAwardsViewController {
            let presenter = EditAwardsPresenter()
            let coordinator = EditAwardsCoordinator(navigationController: navigationController)
            let interactor = EditAwardsInteractor(
                coordinator: coordinator,
                presenter: presenter,
                model: model)
            let viewController = EditAwardsViewController(interactor: interactor)
            presenter.view  = viewController
            
            return viewController
        }
    
}
