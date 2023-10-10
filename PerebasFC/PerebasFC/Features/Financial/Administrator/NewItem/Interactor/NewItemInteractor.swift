//
//  NewItemInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 17/08/23.
//

import Foundation

final class NewItemInteractor: NewItemViewInteractorProtocol {
    
    private let worker: NewItemWorkerProtocol
    private let coordinator: NewItemCoordinatorProtocol
    private let presenter: NewItemPresenterProtocol
    private let type: FinancialAdministratorActions
    
    init(worker: NewItemWorkerProtocol,
         coordinator: NewItemCoordinatorProtocol,
         presenter: NewItemPresenterProtocol,
         type: FinancialAdministratorActions){
        self.coordinator = coordinator
        self.worker = worker
        self.presenter = presenter
        self.type = type
    }
    
    func handleConfirmButtonTap(newItem: NewItemModel) {
        var hasError = false
        
        if newItem.eventName.isEmpty {
            presenter.updateViewForDescriptionFieldErrorState()
            hasError = true
        }
        
        if newItem.eventValue.isEmpty {
            presenter.updateViewForValueFieldErrorState()
            hasError = true
        }
        
        if !hasError{
            coordinator.showLoading()
            worker.createNewItem(
                newItem: newItem,
                type: self.type) { [weak self] succeded in
                    guard let self = self else { return }
                    self.coordinator.removeLoading()
                    
                    if succeded {
                        coordinator.showSuccessFeedback()
                    } else {
                        coordinator.showErrorFeedback()
                    }
                    
                }
        }
        
    }
    
    func handleAddToSpecificPlayerButton() {
        coordinator.handleAddToSpecificPlayerButton()
    }
    
}
