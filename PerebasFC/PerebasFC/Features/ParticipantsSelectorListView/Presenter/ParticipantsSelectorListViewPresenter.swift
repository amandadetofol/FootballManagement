//
//  ParticipantsSelectorListViewPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 04/09/23.
//

import Foundation

protocol ParticipantsSelectorListViewPresenterProtocol {
    func updateView(with model: [User])
}

protocol ParticipantsSelectorListViewProtocol: AnyObject {
    func updateView(model: [ParticipantsSelectorCardViewModel])
}

final class ParticipantsSelectorListViewPresenter: ParticipantsSelectorListViewPresenterProtocol {
    
    weak var view: ParticipantsSelectorListViewProtocol?
   
    func updateView(with model: [User]) {
        view?.updateView(model: parseApiModelToViewModel(model: model))
    }
    
    //MARK: Private methods
    private func parseApiModelToViewModel(model: [User]) -> [ParticipantsSelectorCardViewModel]{
        return model.map { user in
            ParticipantsSelectorCardViewModel(title: "\(user.firstName) \(user.lastName)")
        }
    }

}
