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
            case .myData:
                self.navigationController.pushViewController(
                    PersonalInformationsFactory.getPersonalInformationsViewController(
                        navigationController: navigationController),
                    animated: true)
                return
                
            case .financial:
                return
            case .calendar, .confirmPresence:
                navigationController.pushViewController(
                    CalendarFactory.getCalendarViewController(
                        navigationController: navigationController),
                    animated: true)
                return
                
            case .chat:
                navigationController.pushViewController(
                    ChatMainFactory.getChatMainViewController(
                        navigationController: navigationController),
                    animated: true)
                return
                
            case .ranking:
                self.navigationController.pushViewController(
                    RankingFactory.getRankingViewController(
                        navigationController: navigationController),
                    animated: true)
                return
                
            case .games:
                self.navigationController.pushViewController(
                    GameHistoryViewFactory.getGameHistoryViewController(
                        navigationController: navigationController),
                    animated: true)
                return
                
            case .team:
                guard let teams = teams else { return }
                self.navigationController.pushViewController(
                    WeekTeamFactory.getWeekTeamViewController(teams: teams),
                    animated: true)
                return
            }
        }
    
}
