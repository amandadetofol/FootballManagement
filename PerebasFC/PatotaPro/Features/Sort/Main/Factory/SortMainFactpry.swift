//
//  SortMainFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/08/23.
//

import UIKit

struct SortMainFactory {
    
    static func getSortMainViewController(navigationController: UINavigationController) -> SortMainViewController {
        let coordinator = SortMainCoordinator(navigationController: navigationController)
        let worker = SortMainWorker()
        let presenter = SortMainPresenter()
        let interactor = SortMainInteractor(
            worker: worker,
            presenter: presenter,
            coordinator: coordinator)
        let viewController = SortMainViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}
