//
//  EmailSenderFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 20/10/23.
//

import UIKit

struct EmailSenderFactory {
    
    static func getEmailSenderViewController(navigationController: UINavigationController) -> EmailSender {
        let coordinator = EmailSenderCoordinator(navigationController: navigationController)
        let interactor = EmailSenderInteractor(coordinator: coordinator)
        
        return  EmailSender(interactor: interactor)
    }
    
}
