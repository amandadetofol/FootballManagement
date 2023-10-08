//
//  CalendarInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 11/06/23.
//  Created by Amanda Detofol on 11/06/23.
//

import Foundation
import FirebaseFirestore

protocol CalendarPresenterProtocol {
    func updateEvents(events: QuerySnapshot)
    func showConfirmPresencePopUp(model: NewEventInCalendarViewModel)
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
        coordinator.showLoading()
        worker.getCalendarEvents { [weak self] eventDays in
            guard let self,
                  let eventDays else {
                self?.coordinator.removeLoading()
                self?.coordinator.showErrorAlert()
                return
            }
            self.coordinator.removeLoading()
            self.presenter.updateEvents(events: eventDays)
        }
    }
    
    func showConfirmPresencePopUp(model: NewEventInCalendarViewModel) {
        presenter.showConfirmPresencePopUp(model: model)
    }
    
    func showCreateNewEventPopUp(date: Date) {
        presenter.showCreateNewEventPopUp(date: date)
    }
    
    func showEventForSelectedDayPopUpNotFound(date: Date) {
        presenter.showEventForSelectedDayPopUpNotFound(date: date)
    }
    
    func handlePopUpButtonTap(
        key: String,
        model: NewEventInCalendarViewModel?,
        date: Date?) {
            switch key {
            case CalendarPopUpKeysEnum.close.rawValue:
                coordinator.goToBack()
            case CalendarPopUpKeysEnum.createNewEvent.rawValue:
                coordinator.goToCreateNewEvent(date: date ?? Date())
            case CalendarPopUpKeysEnum.confirmPresence.rawValue:
                coordinator.showConfirmationPopUp(
                    numberOfCompanions: model?.numberOfCompanios ?? 0,
                    completion: { [weak self] presence, numberOfCompanions in
                        guard let self,
                              let model else { return }
                        if presence == true {
                            self.worker.saveNewUserInPresenceList(
                                numberOfCompanions: numberOfCompanions ?? 0,
                                itemId: model.id ?? "") { succeded in
                                    if succeded {
                                        self.coordinator.showSuccessAlert()
                                    } else {
                                        self.coordinator.showErrorAlert()
                                    }
                                }
                        } else {
                            coordinator.goToBack()
                        }
                      
                    })
                
            case CalendarPopUpKeysEnum.presenceList.rawValue:
                guard let model else { return }
                coordinator.goToSeePresenceList(itemId: model.id ?? "")
            default:
                return
            }
        }
    
}
