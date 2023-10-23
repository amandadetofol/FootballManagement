//
//  EmailSenderInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 20/10/23.
//

import UIKit

final class EmailSenderInteractor: EmailSenderInteractorProtocol {
    
    private let coordinator: EmailSenderCoordinatorProtocol
    
    init(coordinator: EmailSenderCoordinatorProtocol){
        self.coordinator = coordinator
    }
    
    func showAlert() {
        coordinator.showErrorAlert()
    }
    
    func showSuccessAlert() {
        coordinator.showSuccessAlert()
    }
    
    func showEmailUnavailableAlert() {
        coordinator.showEmailUnavailableAlert()
    }
    
    func showEmailView(controller: UIViewController) {
        coordinator.showMailView(controller: controller)
    }
    
    func popEmailView(controller: UIViewController) {
        coordinator.popEmailView(controller: controller)
    }
    
}
