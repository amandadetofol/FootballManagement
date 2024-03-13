//
//  PersonalInformationsPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import Foundation

protocol PersonalInformationsViewProtocol: AnyObject {
    func handleGoToEditDataFlow()
    func hideDeleteButton()
    func updateView(with model: PersonalInformationsViewModel)
    func handleEdit()
    func setupViewForUserNameTextFieldErrror()
    func setupViewForLastNameTextFieldError()
    func setupViewForShirtNumberTextFieldError()
    func setupViewForPositionNumberTextFieldHasError()
    func setupViewForMedicalInsuranceTextFieldError()
    func setupViewForEmergencyPhoneNumberTextFieldError()
}

final class PersonalInformationsPresenter: PersonalInformationsPresenterProtocol {
    
    weak var view: PersonalInformationsViewProtocol?
    
    func handleGoToEditDataFlow() {
        view?.handleGoToEditDataFlow()
    }
    
    func updateView(with model: PersonalInformationsViewModel) {
        view?.updateView(with: model)
    }
    
    func hideDeleteButton(){
        view?.hideDeleteButton()
    }
    
    func setupViewForUserNameTextFieldErrror(){
        view?.setupViewForUserNameTextFieldErrror()
    }
    
    func setupViewForLastNameTextFieldError(){
        view?.setupViewForLastNameTextFieldError()
    }
    
    func setupViewForShirtNumberTextFieldError(){
        view?.setupViewForShirtNumberTextFieldError()
    }
    
    func setupViewForPositionNumberTextFieldHasError(){
        view?.setupViewForPositionNumberTextFieldHasError()
    }
    
    func setupViewForMedicalInsuranceTextFieldError(){
        view?.setupViewForMedicalInsuranceTextFieldError()
    }
    
    func setupViewForEmergencyPhoneNumberTextFieldError(){
        view?.setupViewForEmergencyPhoneNumberTextFieldError()
    }
    
    func handleEdit(){
        view?.handleEdit()
    }
    
}
