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
    func hideDeleteButton()
    func updateView(with model: PersonalInformationsViewModel)
    func setupViewForUserNameTextFieldErrror()
    func setupViewForLastNameTextFieldError()
    func setupViewForShirtNumberTextFieldError()
    func setupViewForPositionNumberTextFieldHasError()
    func setupViewForMedicalInsuranceTextFieldError()
    func setupViewForEmergencyPhoneNumberTextFieldError()
    func handleEdit()
}

final class PersonalInformationsInteractor: PersonalInformationsInteractorProtocol {

    private let coordinator: PersonalInformationsCoordinatorProtocol
    private let presenter: PersonalInformationsPresenterProtocol
    private let worker: PersonalInformationsWorkerProtocol
    var email: String?
    
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
        worker.getPersonalInformations({ [weak self] data in
            guard let self else { return }
            
            guard let data = data else {
                self.coordinator.removeLoading()
                self.coordinator.showErrorMessageAlert()
                return
            }
            self.coordinator.removeLoading()
            self.presenter.updateView(with: data)
        },
        email: self.email)
        
        if let _ = self.email {
            presenter.hideDeleteButton()
        }
    }
    
    func handleGoToChangePasswordFlow() {
        coordinator.handleGoToChangePasswordFlow()
    }
    
    func handleGoToEditDataFlow() {
        presenter.handleGoToEditDataFlow()
    }
    
    func handleEdit(
        model: PersonalInformationsViewModel,
        changeImage: Bool){
            
            var hasError = false
            
            if model.name.isEmpty {
                presenter.setupViewForUserNameTextFieldErrror()
                hasError = true
            }
            
            if model.lastName.isEmpty {
                presenter.setupViewForLastNameTextFieldError()
                hasError = true
            }
            
            if model.shirtNumber.isEmpty {
                presenter.setupViewForShirtNumberTextFieldError()
                hasError = true
            }
            
            if model.position.isEmpty {
                presenter.setupViewForPositionNumberTextFieldHasError()
                hasError = true
            }
               
            if model.medicalInsurance.isEmpty {
                presenter.setupViewForMedicalInsuranceTextFieldError()
                hasError = true
            }
            
            if model.emergencyPhoneNumber.isEmpty {
                presenter.setupViewForEmergencyPhoneNumberTextFieldError()
                hasError = true
            }
             
            if !hasError {
                worker.updatePersonalInformations(
                    personalInformations: model,
                    changeImage: changeImage,
                    completion: { [weak self] succeded in
                        guard let self else { return }
                        
                        if succeded {
                            self.coordinator.showUpdateSuccessPopUp()
                        } else {
                            self.coordinator.showUpdateErrorPopUp()
                        }
                    },
                email: email)
                
                presenter.handleEdit()
            }
    
        }
    
    func handleGoToBlockEdition() {
        presenter.handleGoToBlockEdition()
    }
    
    func handleDeleteUserButtonTap(user: PersonalInformationsViewModel) {
        guard let email = user.email else { return }
        coordinator.showLoading()
        worker.deleteUser(email: email) { [weak self] succeded in
            guard let self = self else { return }
            coordinator.removeLoading()
            if succeded{
                self.coordinator.showDeleteUserSuccessPopUp(email: email)
            } else {
                self.coordinator.showErrorMessageAlert()
            }
        }
    }
    
}
