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
        coordinator.showLoading()
        worker.getPersonalInformations { [weak self] data in
            guard let self else { return }
            
            guard let data = data else {
                self.coordinator.removeLoading()
                self.coordinator.showErrorMessageAlert()
                return
            }
            self.coordinator.removeLoading()
            self.presenter.updateView(with: data)
        }
    }
    
    func handleGoToChangePasswordFlow() {
        coordinator.handleGoToChangePasswordFlow()
    }
    
    func handleGoToEditDataFlow() {
        presenter.handleGoToEditDataFlow()
    }
    
    func handleEdit(model: PersonalInformationsViewModel){
           worker.updatePersonalInformations(personalInformations: model) { [weak self] succeded in
            guard let self else { return }
            
            if succeded {
                self.coordinator.showUpdateSuccessPopUp()
            } else {
                self.coordinator.showUpdateErrorPopUp()
            }
        }
    }
    
    func handleGoToBlockEdition() {
        presenter.handleGoToBlockEdition()
    }
    
    func handleDeleteUserButtonTap(user: PersonalInformationsViewModel) {
        coordinator.showDeleteUserConfirmationModal(userName: user.name) { [weak self] in
            self?.coordinator.goToBack()
        }
    }
    
}
