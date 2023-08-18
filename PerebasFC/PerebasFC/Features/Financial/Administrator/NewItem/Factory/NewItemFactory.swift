//
//  NewItemFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 17/08/23.
//

import UIKit

struct NewItemFactory {
    
    static func getNewItemFactory(
        navigationController: UINavigationController,
        type: NewItemType) -> NewItemViewController {
            let coordinator = NewItemCoordinator(navigationController: navigationController)
            let worker = NewItemWorker()
            let interactor = NewItemInteractor(
                worker: worker,
                coordinator: coordinator)
            return NewItemViewController(
                type: type,
                interactor: interactor)
    }
    
}
