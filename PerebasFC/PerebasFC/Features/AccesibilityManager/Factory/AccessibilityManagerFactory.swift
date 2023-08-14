//
//  AccessibilityManagerFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 13/08/23.
//

import UIKit

struct AccessibilityManagerFactory {
    
    static func getAccessibilityManagaerFactory(model: [AccessibilityManagerViewModel]) -> AccessibilityManagerViewController {
        let presenter = AccessibilityManagerPresenter()
        let coordinator = AccessibilityManagerCoordinator()
        let interactor = AccessibilityManagerInteractor(
            presenter: presenter,
            coordinator: coordinator,
            model: model)
        let viewController = AccessibilityManagerViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}
