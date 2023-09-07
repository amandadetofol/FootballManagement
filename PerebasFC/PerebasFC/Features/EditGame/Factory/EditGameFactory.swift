//
//  EditGameFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 24/07/23.
//

import UIKit

struct EditGameFactory {
    
    static func getEditGameViewController(
        navigationController: UINavigationController,
        model: Game,
        isNewGame: Bool) -> EditGameViewController {
            let presenter = EditGamePresenter()
            let coordinator = EditGameCoordinator(navigationController: navigationController)
            let interactor = EditGameInteractor(
                presenter: presenter,
                coordinator: coordinator,
                model: model,
                isNewGame: isNewGame)
            let viewController = EditGameViewController(interactor: interactor)
            presenter.view = viewController
            
            return viewController
        }
    
}
