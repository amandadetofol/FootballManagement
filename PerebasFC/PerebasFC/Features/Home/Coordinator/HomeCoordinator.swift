//
//  HomeCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 25/05/23.
//

import UIKit

typealias HomeCoordinatorProtocolWithLoaderProtocol = LoaderCoodinatorProtocol & HomeCoordinatorProtocol

protocol HomeCoordinatorProtocol {
    func handleLogout()
    func handleAlertCloseButtonTap()
    func handleAccessibilityButtonTap(model: [AccessibilityManagerViewModel])
    func handleInternalLinkRedirect(
        key: InternalLinkRedirectKeys,
        willShow: Bool?,
        teams: WeekTeamViewModel?)
}

final class HomeCoordinator: HomeCoordinatorProtocolWithLoaderProtocol {
    
    private let navigationController: UINavigationController
    private let loaderCoordinator: LoaderCoodinatorProtocol
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.loaderCoordinator = LoaderCoodinator(navigationController: navigationController)
    }
    
    func showLoader() {
        loaderCoordinator.showLoader()
    }
    
    func removeLoader() {
        loaderCoordinator.removeLoader()
    }
    
    func handleLogout() {
        showLoader()
        SignOutWorker.signOut { [weak self] succeded in
            guard let self = self else { return }
            switch succeded {
                case true:
                    self.removeLoader()
                    self.navigationController.popViewController(animated: true)
                case false:
                    self.removeLoader()
                    self.showErrorPopUp()
            }
        }
    }
    
    func handleAccessibilityButtonTap(model: [AccessibilityManagerViewModel]){
        navigationController.present(
            AccessibilityManagerFactory.getAccessibilityManagaerFactory(model: model),
            animated: true)
    }
    
    func handleAlertCloseButtonTap() {
        
    }
    
    func handleInternalLinkRedirect(
        key: InternalLinkRedirectKeys,
        willShow: Bool? = false,
        teams: WeekTeamViewModel? = nil) {
            switch key {
            case .map:
                self.navigationController.pushViewController(
                    MapFactory.getMapViewController(
                        navigationController: navigationController), animated: true)
                return 
                
            case .myData:
                self.navigationController.pushViewController(
                    PersonalInformationsFactory.getPersonalInformationsViewController(
                        navigationController: navigationController),
                    animated: true)
                return
                
            case .financial:
                if Session.shared.isAdm ?? false {
                    navigationController.pushViewController(
                        FinancialAdministratorMainFactory.getFinancialAdministratorMainViewController(
                            navigationController: navigationController,
                            model: FinancialAdministratorMainViewModel(
                                username: "José Maria",
                                balance: "R$ 400,00")),
                        animated: true)
                    return
                }
                
                navigationController.pushViewController(
                    FinancialFactory.getFinancialViewController(
                        navigationController: navigationController),
                    animated: true)
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
            case .participants:
                self.navigationController.pushViewController(
                    PariticpantsManagerFactory.getParticipantsViewController(
                        navigationController: navigationController),
                    animated: true)
                
            case .sort:
                self.navigationController.pushViewController(
                    SortMainFactory.getSortMainViewController(
                        navigationController: navigationController),
                    animated: true)
            case .out:
                self.handleLogout()
            }
        }
    
    //MARK: Private methods
    private func showErrorPopUp() {
        let alert = UIAlertController(
            title: "Ops!",
            message: "Algo deu errado :( \n Tente novamente!",
            preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(
            UIAlertAction(
                title: "ok".uppercased(),
                style: UIAlertAction.Style.default,
                handler: { [weak self] _ in
                    self?.navigationController.popViewController(animated: true)
                }))

        navigationController.present(
            alert,
            animated: true)
    }
    
    
}
