//
//  EventPresencePresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/09/23.
//

import Foundation

protocol EventPresencePresenterProtocol {
    func updateView(with model: [EventPresenceCardViewModel])
}

protocol EventPresenceViewProtocol: AnyObject {
    func updateView(with model: [EventPresenceCardViewModel])
}

final class EventPresencePresenter: EventPresencePresenterProtocol {
    
    weak var view: EventPresenceViewProtocol?
    
    func updateView(with model: [EventPresenceCardViewModel]){
        view?.updateView(with: model)
    }
    
}
