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
        type: NewItemType,
        admtype: FinancialAdministratorActions) -> NewItemViewController {
            let coordinator = NewItemCoordinator(navigationController: navigationController)
            let worker = NewItemWorker()
            let presenter = NewItemPresenter()
            let interactor = NewItemInteractor(
                worker: worker,
                coordinator: coordinator,
                presenter: presenter,
                type: admtype)
            let controller = NewItemViewController(
                type: type,
                interactor: interactor)
            presenter.view = controller
            
            return controller
    }
    
}
