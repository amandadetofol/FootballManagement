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
}

struct Score {
    let whiteTeamPoints: Int
    let blackTeamPoints: Int
}

struct Goals {
    let playerName: String
    let time: String
}
