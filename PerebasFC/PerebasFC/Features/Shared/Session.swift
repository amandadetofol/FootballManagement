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
        let user1 = User(id: "01", firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .goalKepper, menuItems: [])
        let user2 = User(id: "02", firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .goalKepper, menuItems: [])
        let user3 = User(id: "03", firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .member, menuItems: [])
        let user4 = User(id: "04",firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .member, menuItems: [])
        let user5 = User(id: "05",firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .player, menuItems: [])
        let user6 = User(id: "06",firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .player, menuItems: [])
        let user7 = User(id: "07",firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .player, menuItems: [])
        let user8 = User(id: "08",firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .player, menuItems: [])
        let user9 = User(id: "09",firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .player, menuItems: [])
        let user10 = User(id: "10",firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .player, menuItems: [])
        let user11 = User(id: "11",firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, type: .player, menuItems: [])
        
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
