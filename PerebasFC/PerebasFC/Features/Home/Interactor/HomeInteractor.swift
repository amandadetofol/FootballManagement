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
    private let coordinator: HomeCoordinatorProtocol
    
    init(homeViewModel: User,
         presenter: HomePresenterProtocol,
         coordinator: HomeCoordinatorProtocol) {
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
        let user1 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        let user2 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        let user3 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        let user4 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        let user5 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        let user6 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        let user7 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        let user8 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        let user9 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        let user10 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        let user11 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        
        let users: [User] = [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10,
            user11
        ]

        
        let teams = WeekTeamViewModel(
            whiteTeam: Team(players: users),
            blackTeam: Team(players: users))
        
        coordinator.handleInternalLinkRedirect(
            key: key,
            willShow: false,
            teams: teams)
    }
    
}
