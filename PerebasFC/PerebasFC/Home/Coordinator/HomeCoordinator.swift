//
//  HomeCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 25/05/23.
//

import UIKit

protocol HomeCoordinatorProtocol {
    func handleLogout()
    func handleAlertCloseButtonTap()
    func handleInternalLinkRedirect(key: InternalLinkRedirectKeys)
}

final class HomeCoordinator: HomeCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func handleLogout() {
        
    }
    
    func handleAlertCloseButtonTap() {
        
    }
    
    func handleInternalLinkRedirect(key: InternalLinkRedirectKeys) {
        
    }
    
}
