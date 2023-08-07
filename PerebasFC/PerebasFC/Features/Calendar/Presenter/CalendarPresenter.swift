//
//  CalendarPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 12/06/23.
//

import Foundation

protocol CalendarViewProtocol: AnyObject {
    func updateEvents(events: [Int])
    func showConfirmPresencePopUp(date: Date)
    func showCreateNewEventPopUp(date: Date)
    func showEventForSelectedDayPopUpNotFound(date: Date)
}

final class CalendarPresenter: CalendarPresenterProtocol {
    
    weak var view: CalendarViewProtocol?
    
    func updateEvents(events: [Int]) {
        view?.updateEvents(events: events)
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
    
}
