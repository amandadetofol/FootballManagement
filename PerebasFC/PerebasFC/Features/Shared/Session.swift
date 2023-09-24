//
//  Session.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 15/06/23.
//

import Foundation

final class Session {
    
    static let shared = Session()
    
    private init() {}
    
    var isAdm: Bool?
    var user: User?
    var loggedUserEmail: String?
    
    var players: [User] {
        get {
            return getMockUsers()
        }
    }
    
    private func getMockUsers() -> [User] {
        let user1 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .goalKepper, menuItems: [])
        let user2 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .goalKepper, menuItems: [])
        let user3 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .member, menuItems: [])
        let user4 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .member, menuItems: [])
        let user5 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .player, menuItems: [])
        let user6 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .player, menuItems: [])
        let user7 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .player, menuItems: [])
        let user8 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .player, menuItems: [])
        let user9 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .player, menuItems: [])
        let user10 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .player, menuItems: [])
        let user11 = User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .player, menuItems: [])
        
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
        
        return users
    }
}
