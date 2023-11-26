//
//  GameHistoryViewFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 30/05/23.
//

import UIKit

final class GameHistoryViewFactory {
    
    static func getGameHistoryViewController(navigationController: UINavigationController) -> GamesHistoryViewController {
        let coordinator = GamesHistoryCoordinator(navigationController: navigationController)
        let worker = GamesHistoryWorker()
        let presenter = GamesHistoryPresenter()
        let interactor = GamesHistoryInteractor(
            presenter: presenter,
            worker: worker,
            coordinator: coordinator)
        let viewController = GamesHistoryViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}
