//
//  NewEventInCalendarInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/07/23.
//

import Foundation



final class NewEventInCalendarInteractor: NewEventInCalendarViewInteractorProtocol {
    
    private let selectedDate: Date
    private let coordinator: NewEventInCalendarCoordinatorProtocol
    private let presenter: NewEventInCalendarPresenterProtocol
    private let worker: NewEventInCalendarWorkerProtocol
    
    init(coordinator: NewEventInCalendarCoordinatorProtocol,
         worker: NewEventInCalendarWorkerProtocol,
         presenter: NewEventInCalendarPresenterProtocol,
         selectedDate: Date){
        self.coordinator = coordinator
        self.worker = worker
        self.selectedDate = selectedDate
        self.presenter = presenter
    }
    
    func viewDidLoad() {
        presenter.updateView(with: selectedDate)
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
