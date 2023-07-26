//
//  CalendarInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 11/06/23.
//  Created by Amanda Detofol on 11/06/23.
//

import Foundation

protocol CalendarPresenterProtocol {
    func updateEvents(events: [Int])
    func showConfirmPresencePopUp()
    func showCreateNewEventPopUp()
    func showEventForSelectedDayPopUpNotFound()
}

final class CalendarInteractor: CalendarViewInteractorProtocol {
 
    private let worker: CalendarWorkerProtol
    private let presenter: CalendarPresenterProtocol
    private let coordinator: CalendarCoordinatorProtocol
    
    init(worker: CalendarWorkerProtol,
         presenter: CalendarPresenterProtocol,
         coordinator: CalendarCoordinatorProtocol) {
        self.worker = worker
        self.presenter = presenter
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        worker.getCalendarEvents { [weak self] eventDays in
            self?.presenter.updateEvents(events: eventDays)
        }
    }
    
    func showConfirmPresencePopUp() {
        presenter.showConfirmPresencePopUp()
    }
    
    func showCreateNewEventPopUp() {
        presenter.showCreateNewEventPopUp()
    }
    
    func showEventForSelectedDayPopUpNotFound() {
        presenter.showEventForSelectedDayPopUpNotFound()
    }
    
    func handlePopUpButtonTap(key: String) {
        switch key {
            case CalendarPopUpKeysEnum.close.rawValue:
                coordinator.goToBack()
            case CalendarPopUpKeysEnum.createNewEvent.rawValue:
                coordinator.goToCreateNewEvent()
            case CalendarPopUpKeysEnum.confirmPresence.rawValue:
                coordinator.showConfirmationPopUp()
            default:
                return
        }
    }
    
}