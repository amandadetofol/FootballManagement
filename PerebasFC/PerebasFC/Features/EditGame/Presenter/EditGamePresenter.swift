//
//  EditGamePresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/06/23.
//

import Foundation
import FirebaseFirestore

protocol EditGamePresenterProtocol: AnyObject {
    func addListOfPresenceButton()
    func updateView(
        with game: Game,
        players: QuerySnapshot)
}

protocol EditGameViewProtocol: AnyObject {
    func updateView(
        with game: Game,
        players: [String])
    func addListOfPresenceButton()
}

final class EditGamePresenter: EditGamePresenterProtocol {
    
    weak var view: EditGameViewProtocol?
    
    func updateView(with game: Game, players: QuerySnapshot) {
        var users = parseQuerySnapshotIntoUsersArray(model: players)
        var names: [String] = []
        users?.forEach({ user in
            names.append(user.name)
        })
        
        view?.updateView(with: game, players: names)
    }
    
    func addListOfPresenceButton(){
        view?.addListOfPresenceButton()
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
                        rankingPosition: document["rankingPlace"] as? Float ?? 0.0,
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
