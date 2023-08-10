//
//  ParticipantsManagerPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/08/23.
//

import Foundation

protocol ParticipantsManagerViewProtocol: AnyObject {
    func updateView(with model: [ParticipantCellModel])
    func updateView(basedOn participantType: ParticipantType)
}

protocol ParticipantsManagerPresenterProtocol {
    func updateView(with model: [User])
    func updateView(basedOn segmentedControlIndex: Int)
}

final class ParticipantsManagerPresenter: ParticipantsManagerPresenterProtocol {
    
    weak var view: ParticipantsManagerViewProtocol?
    
    func updateView(with model: [User]) {
        view?.updateView(with: getParticipantCellModel(with: model))
    }
    
    func updateView(basedOn segmentedControlIndex: Int){
        switch segmentedControlIndex {
            case 0:
                view?.updateView(basedOn: .player)
            case 1:
                view?.updateView(basedOn: .goalKepper)
            case 2:
                view?.updateView(basedOn: .member)
            default: break
        }
    }
    
    //MARK: Private methods
    private func getParticipantCellModel(with model: [User]) -> [ParticipantCellModel] {
        return model.map { user in
            ParticipantCellModel(user: user)
        }
    }
    
}
