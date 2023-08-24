//
//  MapFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 23/08/23.
//

import UIKit

struct MapFactory {
    
    static func getMapViewController(navigationController: UINavigationController) -> MapViewController {
        let coordinator = MapCoordinator(navigationController: navigationController)
        let presenter = MapPresenter()
        let worker = MapWorker()
        let interactor = MapInteractor(
            worker: worker,
            presenter: presenter,
            coordinator: coordinator)
        let viewController = MapViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}
