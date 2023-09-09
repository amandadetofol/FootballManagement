//
//  EventPresenceFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/09/23.
//

import UIKit

struct EventPresenceFactory {
    
    static func getEventPresenceViewController(navigationController: UINavigationController) -> EventPresenceViewController {
        let coordinator = EventPresenceCoordinator(navigationController: navigationController)
        let presenter = EventPresencePresenter()
        let worker = EventPresenceWorker()
        let interactor = EventPresenceInteractor(
            coordinator: coordinator,
            presenter: presenter,
            worker: worker)
        let vc = EventPresenceViewController(interactor: interactor)
        presenter.view = vc
        
        return vc 
    }
    
}
