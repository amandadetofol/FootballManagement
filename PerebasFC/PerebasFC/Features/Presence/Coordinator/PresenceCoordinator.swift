//
//  PresenceCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/09/23.
//

import UIKit

protocol PresenceCoordinatorProtocol {
    func handleOkButtonTap()
}

final class PresenceCoordinator: PresenceCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func handleOkButtonTap(){
        //Future worker call
        navigationController.popViewController(animated: true)
    }
    
}
