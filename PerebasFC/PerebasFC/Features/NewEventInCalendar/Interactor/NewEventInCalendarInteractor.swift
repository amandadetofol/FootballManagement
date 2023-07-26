//
//  NewEventInCalendarInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/07/23.
//

import Foundation

final class NewEventInCalendarInteractor: NewEventInCalendarViewInteractorProtocol {
    
    private let coordinator: NewEventInCalendarCoordinatorProtocol
    private let worker: NewEventInCalendarWorkerProtocol
    
    init(coordinator: NewEventInCalendarCoordinatorProtocol,
         worker: NewEventInCalendarWorkerProtocol){
        self.coordinator = coordinator
        self.worker = worker
    }
    
    func handleConfirmButtonTap(_ model: NewEventInCalendarViewModel) {
        worker.saveNewEventInCalendar(model) { [weak self] hasSucceeded in
            switch hasSucceeded {
                case true:
                    self?.coordinator.showSuccessPopUp()
                case false:
                    self?.coordinator.showErrorPopUp()
            }
        }
    }
    
}
