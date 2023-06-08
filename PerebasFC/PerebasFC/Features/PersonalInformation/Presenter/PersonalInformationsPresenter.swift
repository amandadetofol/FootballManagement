//
//  PersonalInformationsPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import Foundation

protocol PersonalInformationsViewProtocol: AnyObject {
    func handleGoToEditDataFlow()
    func handleGoToBlockEdition()
    func updateView(with model: PersonalInformationsViewModel)
}

final class PersonalInformationsPresenter: PersonalInformationsPresenterProtocol {
   
    weak var view: PersonalInformationsViewProtocol?
    
    func handleGoToEditDataFlow() {
        view?.handleGoToEditDataFlow()
    }
    
    func handleGoToBlockEdition() {
        view?.handleGoToBlockEdition()
    }
    
    func updateView(with model: PersonalInformationsViewModel) {
        view?.updateView(with: model)
    }
    
}
