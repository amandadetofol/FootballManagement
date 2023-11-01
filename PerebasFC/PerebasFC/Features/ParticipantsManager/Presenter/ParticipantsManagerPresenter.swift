//
//  ParticipantsManagerPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/08/23.
//

import Foundation
import FirebaseFirestore

protocol ParticipantsManagerViewProtocol: AnyObject {
    func updateView(with model: [ParticipantCellModel])
    func updateView(basedOn participantType: ParticipantType)
    func updateViewForErrorState()
}

protocol ParticipantsManagerPresenterProtocol {
    func updateView(with model: QuerySnapshot?)
    func updateView(basedOn segmentedControlIndex: Int)
}

final class ParticipantsManagerPresenter: ParticipantsManagerPresenterProtocol {
    
    weak var view: ParticipantsManagerViewProtocol?
    
    func updateView(with model: QuerySnapshot?) {
        guard let viewModel = parseQuerySnapshotIntoUsersArray(model: model) else {
            view?.updateViewForErrorState()
            return
        }
        view?.updateView(with: viewModel)
        updateView(basedOn: 1)
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
    
    private func parseQuerySnapshotIntoUsersArray(model: QuerySnapshot?) -> [ParticipantCellModel]? {
        guard let model else {
            return nil
        }
        
        var users: [ParticipantCellModel] = []
        model.documents.forEach { document in
            users.append(
                ParticipantCellModel(
                    user: User(
                        firstName: document["name"] as? String ?? "",
                        lastName: document["lastname"] as? String ?? "",
                        shirtNumber: document["shirtNumber"] as? String ?? "",
                        position: document["position"] as? String ?? "",
                        team: document["team"] as? String ?? "", 
                        warning: nil,
                        rankingPosition: document["rankingPlace"] as? Float ?? 0,
                        isAdm: Session.shared.isAdm ?? false,
                        type: ParticipantType(rawValue: document["type"] as? String ?? "") ?? .member,
                        menuItems: nil,
                        email: document["email"] as? String ?? "")
                )
            )
        }
        
        return users
    }
    
}
