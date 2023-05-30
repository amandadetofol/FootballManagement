//
//  WeekTeamInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 29/05/23.
//

import Foundation

protocol WeekTeamPresenterProtocol {
    func updateTeam(basedOn index: Int, teams: WeekTeamViewModel)
}

final class WeekTeamInteractor: WeekTeamInteractorProtocol {
    
    private let presenter: WeekTeamPresenterProtocol
    private let teams: WeekTeamViewModel
    
    init(
        presenter: WeekTeamPresenterProtocol,
        teams: WeekTeamViewModel){
            self.presenter = presenter
            self.teams = teams
    }
    
    func updateTeam(basedOn index: Int) {
        presenter.updateTeam(basedOn: index, teams: teams)
    }
    
}
