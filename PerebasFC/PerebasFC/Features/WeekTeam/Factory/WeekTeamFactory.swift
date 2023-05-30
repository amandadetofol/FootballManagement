//
//  WeekTeamFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 29/05/23.
//

import Foundation

final class WeekTeamFactory {
    
    static func getWeekTeamViewController(teams: WeekTeamViewModel) -> WeekTeamViewController{
        let presenter = WeekTeamPresenter()
        let interactor = WeekTeamInteractor(
            presenter: presenter,
            teams: teams)
        let viewController = WeekTeamViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}
