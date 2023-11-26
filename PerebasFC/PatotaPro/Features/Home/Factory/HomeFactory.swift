//
//  HomeFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 25/05/23.
//

import UIKit

final class HomeFactory {
    
    static func getHomeViewController(navigationController: UINavigationController, menuItems: [MenuItemViewModel]) -> HomeViewController {
        let coordinator = HomeCoordinator(navigationController: navigationController)
        let presenter = HomePresenter()
        let worker = HomeWorker()
        let interactor = HomeInteractor(
            homeViewModel: menuItems,
            presenter: presenter,
            coordinator: coordinator,
            worker: worker)
        let viewController = HomeViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}
