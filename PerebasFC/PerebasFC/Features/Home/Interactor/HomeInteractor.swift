//
//  HomeInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 25/05/23.
//

import Foundation

protocol HomePresenterProtocol {
    func updateViewForState(isAdm: Bool, model: User)
}

final class HomeInteractor: HomeInteractorProtocol {
    
    private let homeViewModel: User
    private let presenter: HomePresenterProtocol
    private let coordinator: HomeCoordinatorProtocolWithLoaderProtocol
    
    init(homeViewModel: User,
         presenter: HomePresenterProtocol,
         coordinator: HomeCoordinatorProtocolWithLoaderProtocol) {
        self.homeViewModel = homeViewModel
        self.presenter = presenter
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        presenter.updateViewForState(
            isAdm: homeViewModel.isAdm,
            model: homeViewModel)
    }
    
    func handleLogout() {
        coordinator.handleLogout()
    }
    
    func handleAlertCloseButtonTap() {
        coordinator.handleAlertCloseButtonTap()
    }
    
    func handleInternalLinkRedirect(key: InternalLinkRedirectKeys) {
        let teams = WeekTeamViewModel(
            whiteTeam: Team(players: Session.shared.players),
            blackTeam: Team(players: Session.shared.players))
        
        coordinator.handleInternalLinkRedirect(
            key: key,
            willShow: false,
            teams: teams)
    }
    
}
