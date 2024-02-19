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
        presenter.updateView(with: model)
    }
    
    func handleSendNotificationButtonTap(model: FinancialAdministratorPendenciesListCardModel) {
        coordinator.sendEmail(
            to: model.userName,
            information: model)
    }
    
    func handleConfirmButtonTap(url: String?) {
        coordinator.openUrl(url: url)
    }
    
    func handleSaveButton(model: FinancialAdministratorPendenciesListCardModel) {
        coordinator.showLoading { [weak self] in 
            guard let self else { return}
            worker.updateItemInFirebase(model: model) { succeded in
                self.coordinator.removeLoading {
                    if succeded {
                        self.coordinator.showSuccessAlert()
                    } else {
                        self.coordinator.showErrorAlert()
                    }
                }
            }
        }
    }
    
    func handleAprooveButton(model: FinancialAdministratorPendenciesListCardModel){
        coordinator.showLoading { [weak self] in
            guard let self = self else { return}
            self.worker.aprooveItem(model: model) { succeded in
                self.coordinator.removeLoading {
                    
                    if succeded {
                        self.coordinator.showSuccessAlert()
                    } else {
                        self.coordinator.showErrorAlert()
                    }
                }
            }
        }
    }

}

