//
//  GameCardViewModel.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 30/05/23.
//

import Foundation

struct Game {
    let score: Score?
    let gameDate: String
    let goals: [Goals]?
    let date: Date
}

struct Score {
    
    var totalPoints: Int {
        get {
            return whiteTeamPoints + blackTeamPoints
        }
    }
    
    let whiteTeamPoints: Int
    let blackTeamPoints: Int
}

struct Goals {
    let player: User
    let time: Date
    let index: Int 
}
