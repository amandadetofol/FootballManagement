//
//  RankingFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import UIKit

final class RankingFactory {
    
    static func getRankingViewController(navigationController: UINavigationController) -> RankingViewController {
        let coordinator = RankingCoordinator(navigationController: navigationController)
        let worker = RankingWorker()
        let presenter = RankingPresenter()
        let interactor = RankingInteractor(
            presenter: presenter,
            worker: worker,
            coordinator: coordinator)
        let viewController = RankingViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}
