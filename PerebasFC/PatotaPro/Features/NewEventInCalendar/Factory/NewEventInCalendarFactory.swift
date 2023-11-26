//
//  NewEventInCalendarFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/07/23.
//

import UIKit

struct NewEventInCalendarFactory {
    
    static func getNewEventInCalendarViewController(navigationController: UINavigationController, date: Date) -> NewEventInCalendarViewController {
        let coordinator = NewEventInCalendarCoordinator(navigationController: navigationController)
        let worker = NewEventInCalendarWorker()
        let presenter = NewEventInCalendarPresenter()
        let interactor = NewEventInCalendarInteractor(
            coordinator: coordinator,
            worker: worker,
            presenter: presenter,
            selectedDate: date)
        let controller = NewEventInCalendarViewController(interactor: interactor)
        presenter.view = controller
        
        return controller
    }
    
}
