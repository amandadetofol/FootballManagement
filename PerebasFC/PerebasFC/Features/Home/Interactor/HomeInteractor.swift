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
        let user1 = User(id: "01", firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        let user2 = User(id: "02", firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        let user3 = User(id: "03", firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        let user4 = User(id: "04",firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        let user5 = User(id: "05",firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        let user6 = User(id: "06",firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        let user7 = User(id: "07",firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        let user8 = User(id: "08",firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        let user9 = User(id: "09",firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        let user10 = User(id: "10",firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        let user11 = User(id: "11",firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: [])
        
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
