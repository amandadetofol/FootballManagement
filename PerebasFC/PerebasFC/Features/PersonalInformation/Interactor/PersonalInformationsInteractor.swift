//
//  PersonalInformationsInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import Foundation

protocol PersonalInformationsPresenterProtocol {
    func handleGoToEditDataFlow()
    func handleGoToBlockEdition()
    func updateView(with model: PersonalInformationsViewModel)
}

final class PersonalInformationsInteractor: PersonalInformationsInteractorProtocol {
    
    private let coordinator: PersonalInformationsCoordinatorProtocol
    private let presenter: PersonalInformationsPresenterProtocol
    private let worker: PersonalInformationsWorkerProtocol
    
    init(
        coordinator: PersonalInformationsCoordinatorProtocol,
        presenter: PersonalInformationsPresenterProtocol,
        worker: PersonalInformationsWorkerProtocol) {
            self.coordinator = coordinator
            self.presenter = presenter
            self.worker = worker
        }
    
    func viewDidLoad() {
        worker.getPersonalInformations { [weak self] data in
            guard let data = data else {
                self?.coordinator.showErrorMessageAlert()
                return
            }
            self?.presenter.updateView(with: data)
        }
    }
    
    func handleGoToChangePasswordFlow() {
        coordinator.handleGoToChangePasswordFlow()
    }
    
    func handleGoToEditDataFlow() {
        presenter.handleGoToEditDataFlow()
    }
    
    func handleGoToBlockEdition() {
        presenter.handleGoToBlockEdition()
    }
    
}
