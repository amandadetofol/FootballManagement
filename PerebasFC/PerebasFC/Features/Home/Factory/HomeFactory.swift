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
        let interactor = HomeInteractor(
            homeViewModel: menuItems,
            presenter: presenter,
            coordinator: coordinator)
        let viewController = HomeViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}
