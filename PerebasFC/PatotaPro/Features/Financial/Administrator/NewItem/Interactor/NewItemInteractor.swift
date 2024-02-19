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
            coordinator.showLoading { [weak self] in
                guard let self = self else { return }
                self.worker.createNewItem(
                    newItem: newItem,
                    type: self.type) {  succeded in
                        
                        self.coordinator.removeLoading {
                            if succeded {
                                self.coordinator.showSuccessFeedback()
                            } else {
                                self.coordinator.showErrorFeedback()
                            }
                        }
                    }
            }
            
        }
        
    }
    
    func handleAddToSpecificPlayerButton() {
        coordinator.handleAddToSpecificPlayerButton()
    }
    
}
