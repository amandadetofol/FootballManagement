//
//  HomeCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 25/05/23.
//

import UIKit

protocol HomeCoordinatorProtocol {
    func handleLogout()
    func handleAlertCloseButtonTap()
    func handleInternalLinkRedirect(
        key: InternalLinkRedirectKeys,
        willShow: Bool?,
        teams: WeekTeamViewModel?)
}

final class HomeCoordinator: HomeCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func handleLogout() {
        self.navigationController.popViewController(animated: true)
    }
    
    func handleAlertCloseButtonTap() {
        
    }
    
    func handleInternalLinkRedirect(
        key: InternalLinkRedirectKeys,
        willShow: Bool? = false,
        teams: WeekTeamViewModel? = nil) {
            switch key {
                case .confirmPresence(let willShow):
                    return
                case .myData:
                    return
                case .financial:
                    return
                case .calendar:
                    return
                case .chat:
                    return
                case .ranking:
                    return
                case .games:
                    return
                case .team:
                    guard let teams = teams else { return }
                    self.navigationController.pushViewController(
                        WeekTeamFactory.getWeekTeamViewController(teams: teams),
                        animated: true)
            }
    }
    
}
