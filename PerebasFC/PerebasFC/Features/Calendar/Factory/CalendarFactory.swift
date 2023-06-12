//
//  CalendarFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 12/06/23.
//

import UIKit

final class CalendarFactory {
    
    static func getCalendarViewController(navigationController: UINavigationController) -> CalendarViewController {
        let coordinator = CalendarCoordinator(navigationController: navigationController)
        let presenter = CalendarPresenter()
        let worker = CalendarWorker()
        let interactor = CalendarInteractor(
            worker: worker,
            presenter: presenter,
            coordinator: coordinator)
        let viewController = CalendarViewController(
            isAdm: false,
            interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}
