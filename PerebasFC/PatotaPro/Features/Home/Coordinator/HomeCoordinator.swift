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
        willShow: Bool?)
    func showFirstTimeLoggedModal()
}

final class HomeCoordinator: HomeCoordinatorProtocolWithLoaderProtocol {
    
    private let navigationController: UINavigationController
    private let loaderCoordinator: LoaderCoodinatorProtocol
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.loaderCoordinator = LoaderCoodinator(navigationController: navigationController)
    }
    
    func showLoader(_ completion: @escaping(()->Void)) {
        loaderCoordinator.showLoader(completion)
    }
    
    func removeLoader(_ completion: @escaping(()->Void)) {
        loaderCoordinator.removeLoader(completion)
    }
    
    func handleLogout() {
        showLoader { [weak self] in
            SignOutWorker.signOut {  succeded in
                guard let self = self else { return }
                switch succeded {
                case true:
                    self.removeLoader{
                        self.navigationController.popViewController(animated: true)
                    }
                    
                case false:
                    self.removeLoader{
                        self.showErrorPopUp()
                    }
                    
                }
            }
        }
    }
    
    func handleAccessibilityButtonTap(model: [AccessibilityManagerViewModel]){
        let viewController = AccessibilityManagerFactory.getAccessibilityManagaerFactory(model: model)
        viewController.modalPresentationStyle = .pageSheet 
        navigationController.present(
            viewController,
            animated: true)
    }
    
    func handleAlertCloseButtonTap() {
        
    }
    
    func handleInternalLinkRedirect(
        key: InternalLinkRedirectKeys,
        willShow: Bool? = false) {
            switch key {
            case .delete:
                self.navigationController.pushViewController(
                    DeleteTeamFactory.getDeleteTeamViewController(
                        navigationController: navigationController),
                    animated: true)
                return
                
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
                openUrl(url: "whatsapp://")
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
                self.navigationController.pushViewController(
                    WeekTeamFactory.getWeekTeamViewController(
                        teams: nil,
                        shouldCallApi: true,
                        navigationController: navigationController),
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
    
    func showFirstTimeLoggedModal(){
        let alert = UIAlertController(
            title: "Seja bem-vindo!",
            message: "Preencha seus dados pessoais para continuar!",
            preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(
            UIAlertAction(
                title: "Ok".uppercased(),
                style: UIAlertAction.Style.default,
                handler: { [weak self] _ in
                    self?.handleInternalLinkRedirect(
                        key: .myData,
                        willShow: false)
                }))
        
        navigationController.present(
            alert,
            animated: true)
    }
    
    //MARK: Private methods
    private func showErrorPopUp() {
        let alert = UIAlertController(
            title: "Ops!",
            message: "Algo deu errado :( \n Tente novamente!",
            preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(
            UIAlertAction(
                title: "Ok".uppercased(),
                style: UIAlertAction.Style.default,
                handler: { [weak self] _ in
                    self?.navigationController.popViewController(animated: true)
                }))
        
        navigationController.present(
            alert,
            animated: true)
    }
    
    private func openUrl(url: String){
        guard let url = URL(string: url) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
}
