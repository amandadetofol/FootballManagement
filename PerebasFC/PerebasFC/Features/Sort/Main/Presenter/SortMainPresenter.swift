//
//  SortMainPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/08/23.
//

import Foundation
import FirebaseFirestore

protocol SortMainPresenterProtocol {
    func updateView(with model: SortFirebaseIncoming)
}

protocol SortMainViewProtocol: AnyObject {
    func updateView(with model: SortGameMainViewModel)
}

final class SortMainPresenter: SortMainPresenterProtocol {
    
    var view: SortMainViewProtocol?
    
    func updateView(with model: SortFirebaseIncoming){
        view?.updateView(with: getSortGameMainViewModel(model: model))
    }
    
    //MARK: Private func
    private func getSortGameMainViewModel(model: SortFirebaseIncoming) -> SortGameMainViewModel {
        var blackTeams: [Team] = []
        var whiteTeams: [Team] = []
        var isActives: [Bool] = []
        var sortDates: [String] = []
        
        model.otherData.forEach { documentSnapShot in
            isActives.append(documentSnapShot["isActive"] as? Bool ?? false)
            sortDates.append(documentSnapShot["sortDate"] as? String ?? "")
        }
        
        model.whiteTeam.forEach { querySnapShot in
            var players: [User] = []
            querySnapShot.documents.forEach { document in
                players.append(
                    User(
                        firstName: document["name"] as? String ?? "",
                        lastName: document["lastname"] as? String ?? "",
                        shirtNumber: document["shirtNumber"] as? String ?? "",
                        position: document["position"] as? String ?? "",
                        team: document["team"] as? String ?? "",
                        warning: nil,
                        rankingPosition: document["rankingPlace"] as? Float ?? 0,
                        isAdm: Session.shared.isAdm ?? false,
                        type: ParticipantType(rawValue: document["type"] as? String ?? "") ?? .player,
                        menuItems: nil,
                        email: document["email"] as? String ?? "",
                        category: document["category"] as? String ?? "")
                )
            }
            whiteTeams.append(Team(players: players))
        }
        
        model.blackTeam.forEach { querySnapShot in
            var players: [User] = []
            querySnapShot.documents.forEach { document in
                players.append(
                    User(
                        firstName: document["name"] as? String ?? "",
                        lastName: document["lastname"] as? String ?? "",
                        shirtNumber: document["shirtNumber"] as? String ?? "",
                        position: document["position"] as? String ?? "",
                        team: document["team"] as? String ?? "",
                        warning: nil,
                        rankingPosition: document["rankingPlace"] as? Float ?? 0,
                        isAdm: Session.shared.isAdm ?? false,
                        type: ParticipantType(rawValue: document["type"] as? String ?? "") ?? .player,
                        menuItems: nil,
                        email: document["email"] as? String ?? "",
                        category: document["category"] as? String ?? "")
                )
            }
            blackTeams.append(Team(players: players))
        }
        
        var sorts: [SortCardViewModel] = []
        for i in 0..<blackTeams.count {
            sorts.append(
                SortCardViewModel(
                    title: "Sorteio realizado em: \(sortDates[i])",
                    description: "Ativo: \(isActives[i] ? "Sim" : "Não")",
                    model: WeekTeamViewModel(
                        whiteTeam: whiteTeams[i],
                        blackTeam: blackTeams[i]),
                    total: blackTeams.count,
                    currentIndex: i+1))
        }
        
        return SortGameMainViewModel(
            sorts: sorts)
        
    }
    
}
