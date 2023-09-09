//
//  EventPresenceCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/09/23.
//

import UIKit

protocol EventPresenceCoordinatorProtocol {
    func handleConfirmButtonTap()
}

final class EventPresenceCoordinator: EventPresenceCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func handleConfirmButtonTap() {
        navigationController.popViewController(animated: true)
    }
    
}
