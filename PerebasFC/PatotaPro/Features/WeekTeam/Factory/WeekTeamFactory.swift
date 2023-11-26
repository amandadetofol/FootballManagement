//
//  WeekTeamFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 29/05/23.
//

import UIKit

final class WeekTeamFactory {
    
    static func getWeekTeamViewController(
        teams: WeekTeamViewModel?,
        shouldCallApi: Bool,
        navigationController: UINavigationController) -> WeekTeamViewController{
            let presenter = WeekTeamPresenter()
            let worker = WeekTeamWithApiCallWorker()
            let coordinator = WeekTeamCoordinator(navigationController: navigationController)
            let interactor = WeekTeamInteractor(
                coordinator: coordinator,
                worker: worker,
                presenter: presenter,
                teams: teams,
                shouldCallApi: shouldCallApi)
            let viewController = WeekTeamViewController(interactor: interactor)
            presenter.view = viewController
            
            return viewController
        }
    
}
