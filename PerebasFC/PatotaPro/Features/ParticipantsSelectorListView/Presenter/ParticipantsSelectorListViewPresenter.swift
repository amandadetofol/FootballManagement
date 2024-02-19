//
//  ParticipantsSelectorListViewPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 04/09/23.
//

import Foundation
import FirebaseFirestore

protocol ParticipantsSelectorListViewPresenterProtocol {
    func updateView(with model: QuerySnapshot)
}

protocol ParticipantsSelectorListViewProtocol: AnyObject {
    func updateView(model: [ParticipantsSelectorCardViewModel])
}

final class ParticipantsSelectorListViewPresenter: ParticipantsSelectorListViewPresenterProtocol {
    
    weak var view: ParticipantsSelectorListViewProtocol?
   
    func updateView(with model: QuerySnapshot) {
        view?.updateView(model: parseApiModelToViewModel(model: model))
    }
    
    //MARK: Private methods
    private func parseApiModelToViewModel(model: QuerySnapshot) -> [ParticipantsSelectorCardViewModel] {
        return model.documents.map({ document in
            ParticipantsSelectorCardViewModel(
                title: "\(document["email"] as? String ?? "")")
        })
    }

}
