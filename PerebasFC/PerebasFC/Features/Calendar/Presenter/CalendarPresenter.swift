//
//  CalendarPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 12/06/23.
//

import Foundation

protocol CalendarViewProtocol: AnyObject {
    func updateEvents(events: [Int])
    func showConfirmPresencePopUp()
    func showCreateNewEventPopUp()
    func showEventForSelectedDayPopUpNotFound()
}

final class CalendarPresenter: CalendarPresenterProtocol {
    
    weak var view: CalendarViewProtocol?
    
    func updateEvents(events: [Int]) {
        view?.updateEvents(events: events)
    }
    
    func showConfirmPresencePopUp() {
        view?.showConfirmPresencePopUp()
    }
    
    func showCreateNewEventPopUp() {
        view?.showCreateNewEventPopUp()
    }
    
    func showEventForSelectedDayPopUpNotFound() {
        view?.showEventForSelectedDayPopUpNotFound()
    }
    
}
