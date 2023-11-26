//
//  EventPresencePresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/09/23.
//

import Foundation
import FirebaseFirestore

protocol EventPresencePresenterProtocol {
    func updateView(with model: QuerySnapshot)
}

protocol EventPresenceViewProtocol: AnyObject {
    func updateView(with model: [EventPresenceCardViewModel])
}

final class EventPresencePresenter: EventPresencePresenterProtocol {
    
    weak var view: EventPresenceViewProtocol?
    
    func updateView(with model: QuerySnapshot){
        view?.updateView(with: parseQuerySnapShotToEventPresenceViewModel(model: model))
    }
    
    //MARK: Private methods
    private func parseQuerySnapShotToEventPresenceViewModel(model: QuerySnapshot) -> [EventPresenceCardViewModel] {
        model.documents.map { document in
            return EventPresenceCardViewModel(
                name: document.documentID,
                companieNumber: document["numberOfCompanions"] as? Int ?? 0)
        }
    }
}
