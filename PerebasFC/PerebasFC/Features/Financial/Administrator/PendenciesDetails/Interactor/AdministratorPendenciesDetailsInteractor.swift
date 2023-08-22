//
//  AdministratorPendenciesDetailsInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 19/08/23.
//

import UIKit
import UserNotifications

final class AdministratorPendenciesDetailsInteractor:
        NSObject,
        AdministratorPendenciesDetailsInteractorProtocol {
    
    private let userNotificationCenter = UNUserNotificationCenter.current()
    private let coordinator: AdministratorPendenciesDetailsCoordinatorProtocol
    private let presenter: AdministratorPendenciesDetailsPresenterProtocol
    private let model: FinancialAdministratorPendenciesListCardModel
    private let worker: AdministratorPendenciesDetailsNotificationWorkerProtocol
    
    init(coordinator: AdministratorPendenciesDetailsCoordinatorProtocol,
         presenter: AdministratorPendenciesDetailsPresenterProtocol,
         model: FinancialAdministratorPendenciesListCardModel,
         worker: AdministratorPendenciesDetailsNotificationWorkerProtocol) {
        self.coordinator = coordinator
        self.presenter = presenter
        self.model = model
        self.worker = worker
    }
    
    func viewDidLoad() {
        requestNotificationAuthorization()
        presenter.updateView(with: model)
    }
    
    func handleSendNotificationButtonTap() {
        worker.sendPaymentMissingNotification()
    }
    
    func handleConfirmButtonTap(url: String?) {
        coordinator.openUrl(url: url)
    }
    
    //MARK: Private methods
    private func requestNotificationAuthorization() {
        self.userNotificationCenter.delegate = self
        
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        self.userNotificationCenter.requestAuthorization(options: authOptions) { _,_  in }
    }
     
}

extension AdministratorPendenciesDetailsInteractor: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {
            completionHandler()
        }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.alert, .badge, .sound])
        }
    
}
