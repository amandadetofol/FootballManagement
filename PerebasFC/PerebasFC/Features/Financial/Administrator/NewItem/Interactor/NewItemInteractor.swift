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
    
    init(worker: NewItemWorkerProtocol,
         coordinator: NewItemCoordinatorProtocol){
        self.coordinator = coordinator
        self.worker = worker
    }
    
    func handleConfirmButtonTap(newItem: NewItemModel) {
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
