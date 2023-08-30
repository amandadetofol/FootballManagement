//
//  WeekTeamPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 29/05/23.
//

import Foundation

protocol WeekTeamViewProtocol: AnyObject {
    func updateView(team: [WeekTeamListViewModel])
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
    
}
