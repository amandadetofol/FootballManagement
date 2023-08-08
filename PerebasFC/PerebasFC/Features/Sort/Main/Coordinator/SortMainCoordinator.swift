//
//  SortMainCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/08/23.
//

import UIKit

protocol SortMainCoordinatorProtocol {
    func goToWeekTeamView(model: WeekTeamViewModel)
}

final class SortMainCoordinator: SortMainCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func goToWeekTeamView(model: WeekTeamViewModel){
        let controller = WeekTeamFactory.getWeekTeamViewController(teams: model)
        navigationController.pushViewController(controller, animated: true)
    }
    
}
