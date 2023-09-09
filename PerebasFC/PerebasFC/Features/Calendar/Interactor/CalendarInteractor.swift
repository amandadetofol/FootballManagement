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
    func showConfirmPresencePopUp(date: Date)
    func showCreateNewEventPopUp(date: Date)
    func showEventForSelectedDayPopUpNotFound(date: Date)
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
    
    func showConfirmPresencePopUp(date: Date) {
        presenter.showConfirmPresencePopUp(date: date)
    }
    
    func showCreateNewEventPopUp(date: Date) {
        presenter.showCreateNewEventPopUp(date: date)
    }
    
    func showEventForSelectedDayPopUpNotFound(date: Date) {
        presenter.showEventForSelectedDayPopUpNotFound(date: date)
    }
    
    func handlePopUpButtonTap(
        key: String,
        date: Date) {
            switch key {
            case CalendarPopUpKeysEnum.close.rawValue:
                coordinator.goToBack()
            case CalendarPopUpKeysEnum.createNewEvent.rawValue:
                coordinator.goToCreateNewEvent(date: date)
            case CalendarPopUpKeysEnum.confirmPresence.rawValue:
                coordinator.showConfirmationPopUp()
            case CalendarPopUpKeysEnum.presenceList.rawValue:
                coordinator.goToSeePresenceList()
            default:
                return
            }
        }
    
}
