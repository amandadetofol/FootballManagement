//
//  NewEventInCalendarPresenterProtocol.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 05/08/23.
//

import Foundation

protocol NewEventInCalendarPresenterProtocol {
    func updateView(with date: Date)
    func updateViewForEmptyEventNameState()
    func updateviewForEmptyHourState()
}

protocol NewEventInCalendarViewProtocol: AnyObject {
    func updateView(with date: Date)
    func updateViewForEmptyEventNameState()
    func updateviewForEmptyHourState()
}

final class NewEventInCalendarPresenter: NewEventInCalendarPresenterProtocol {
    
    weak var view: NewEventInCalendarViewProtocol?
    
    func updateView(with date: Date){
        view?.updateView(with: date)
    }
    
    func updateViewForEmptyEventNameState(){
        view?.updateViewForEmptyEventNameState()
    }
    
    func updateviewForEmptyHourState(){
        view?.updateviewForEmptyHourState()
    }
    
}
