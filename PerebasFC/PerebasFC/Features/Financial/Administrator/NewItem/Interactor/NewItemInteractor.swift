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
    
    init(worker: NewItemWorkerProtocol,
         coordinator: NewItemCoordinatorProtocol,
         presenter: NewItemPresenterProtocol){
        self.coordinator = coordinator
        self.worker = worker
        self.presenter = presenter
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
            worker.createNewItem(
                newItem: newItem) { [weak self] succeded in
                    guard let self = self else { return }
                    
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
