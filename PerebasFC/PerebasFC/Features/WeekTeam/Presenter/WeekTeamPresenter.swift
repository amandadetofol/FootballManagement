//
//  WeekTeamPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 29/05/23.
//

import Foundation
import FirebaseFirestore

protocol WeekTeamViewProtocol: AnyObject {
    func updateView(team: [WeekTeamListViewModel])
    func updateView(team: WeekTeamViewModel)
    func clearView()
}

final class WeekTeamPresenter: WeekTeamPresenterProtocol {
    
    weak var view: WeekTeamViewProtocol?
    
    func updateTeam(basedOn index: Int, teams: WeekTeamViewModel) {
        view?.clearView()
        switch index {
        case 0:
            let parsedTeam = parseApiTeamToViewModel(team: teams.whiteTeam)
            view?.updateView(team: parsedTeam)
        case 1:
            let parsedTeam = parseApiTeamToViewModel(team: teams.blackTeam)
            view?.updateView(team: parsedTeam)
        default:
            break
        }
    }
    
    private func parseApiTeamToViewModel(team: Team) -> [WeekTeamListViewModel] {
        return team.players.map { user in
            WeekTeamListViewModel(
                shirtNumber: Int(user.shirtNumber) ?? 0,
                fullName: user.firstName + user.lastName,
                position: user.position,
                rankingPosition: user.rankingPosition ?? 0,
                currentIndex: 1,
                total: 1)
        }
        
    }
    
    func updateFirebaseModelToViewModel(
        whiteTeam: QuerySnapshot,
        blackTeam: QuerySnapshot){
            view?.updateView(team: getWeekTeamViewModel(blackTeam, whiteTeam))
        }
    
    //MARK: Private methods
    private func getWeekTeamViewModel(_ blackTeam: QuerySnapshot, _ whiteTeam: QuerySnapshot) -> WeekTeamViewModel {
        var black: [User] = []
        var white: [User] = []
        
        blackTeam.documents.forEach {  document in
            black.append(
                User(
                    firstName: document["name"] as? String ?? "",
                    lastName: document["lastname"] as? String ?? "",
                    shirtNumber: document["shirtNumber"] as? String ?? "",
                    position: document["position"] as? String ?? "",
                    team: document["team"] as? String ?? "",
                    warning: nil,
                    rankingPosition: document["rankingPlace"] as? Int ?? 0,
                    isAdm: Session.shared.isAdm ?? false,
                    type: ParticipantType(rawValue: document["type"] as? String ?? "") ?? .player,
                    menuItems: nil,
                    email: document["email"] as? String ?? "",
                    category: document["category"] as? String ?? "")
            )
        }
        
        whiteTeam.documents.forEach {  document in
            white.append(
                User(
                    firstName: document["name"] as? String ?? "",
                    lastName: document["lastname"] as? String ?? "",
                    shirtNumber: document["shirtNumber"] as? String ?? "",
                    position: document["position"] as? String ?? "",
                    team: document["team"] as? String ?? "",
                    warning: nil,
                    rankingPosition: document["rankingPlace"] as? Int ?? 0,
                    isAdm: Session.shared.isAdm ?? false,
                    type: ParticipantType(rawValue: document["type"] as? String ?? "") ?? .player,
                    menuItems: nil,
                    email: document["email"] as? String ?? "",
                    category: document["category"] as? String ?? "")
            )
        }
        
        return WeekTeamViewModel(
            whiteTeam: Team(players: white),
            blackTeam: Team(players: black))
    }
    
}
