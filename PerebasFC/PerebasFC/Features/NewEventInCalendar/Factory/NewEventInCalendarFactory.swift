//
//  NewEventInCalendarFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/07/23.
//

import UIKit

struct NewEventInCalendarFactory {
    
    static func getNewEventInCalendarViewController(navigationController: UINavigationController) -> NewEventInCalendarViewController {
        let coordinator = NewEventInCalendarCoordinator(navigationController: navigationController)
        let worker = NewEventInCalendarWorker()
        let interactor = NewEventInCalendarInteractor(
            coordinator: coordinator,
            worker: worker)
        let controller = NewEventInCalendarViewController(interactor: interactor)
        
        return controller
    }
    
}
