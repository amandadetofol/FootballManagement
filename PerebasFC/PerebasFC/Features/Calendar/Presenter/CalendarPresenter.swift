//
//  CalendarPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 12/06/23.
//

import Foundation
import FirebaseFirestore

protocol CalendarViewProtocol: AnyObject {
    func updateEvents(events: [NewEventInCalendarViewModel])
    func showConfirmPresencePopUp(date: Date)
    func showCreateNewEventPopUp(date: Date)
    func showEventForSelectedDayPopUpNotFound(date: Date)
}

final class CalendarPresenter: CalendarPresenterProtocol {
 
    weak var view: CalendarViewProtocol?
    
    func updateEvents(events: QuerySnapshot) {
        let viewmodel = parseQuerySnapShotToNewEventInCalendarViewModel(events: events)
        view?.updateEvents(events: viewmodel)
    }
    
    func showConfirmPresencePopUp(date: Date) {
        view?.showConfirmPresencePopUp(date: date)
    }
    
    func showCreateNewEventPopUp(date: Date) {
        view?.showCreateNewEventPopUp(date: date)
    }
    
    func showEventForSelectedDayPopUpNotFound(date: Date) {
        view?.showEventForSelectedDayPopUpNotFound(date: date)
    }
    
    //MARK: Private func
    private func parseQuerySnapShotToNewEventInCalendarViewModel(events: QuerySnapshot) -> [NewEventInCalendarViewModel] {
        events.documents.map { document in
            let dataString = document["selectedDate"] as? String ?? ""
            
            return NewEventInCalendarViewModel(
                selectedDate: Date.parseData(dataString),
                eventName: document["eventName"] as? String ?? String(),
                time: document["time"] as? String ?? String(),
                allowedToBringCompanions: document["allowedToBringCompanions"] as? Bool ?? false,
                numberOfCompanios: document["numberOfCompanios"] as? Int ?? 0)
        }
    }
}
