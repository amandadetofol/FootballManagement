//
//  GamesHistoryWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 30/05/23.
//

import Foundation

protocol GamesHistoryWorkerProtocol {
    func getGamesHistory(_ completion: @escaping (([Game]?) -> Void))
}

final class GamesHistoryWorker: GamesHistoryWorkerProtocol {
    
    func getGamesHistory(_ completion: @escaping (([Game]?) -> Void)) {
        let goals1: [Goals] = [
            Goals(playerName: "John", time: "15:23"),
            Goals(playerName: "Michael", time: "28:46"),
            Goals(playerName: "Sarah", time: "33:02")
        ]
        let score1 = Score(whiteTeamPoints: 2, blackTeamPoints: 1)
        let game1 = Game(score: score1, gameDate: "2023-05-29", goals: goals1)

        let goals2: [Goals] = [
            Goals(playerName: "David", time: "9:15"),
            Goals(playerName: "Olivia", time: "21:37")
        ]
        let score2 = Score(whiteTeamPoints: 0, blackTeamPoints: 2)
        let game2 = Game(score: score2, gameDate: "2023-06-05", goals: goals2)

        let goals3: [Goals] = [
            Goals(playerName: "Robert", time: "3:50"),
            Goals(playerName: "Emily", time: "12:12"),
            Goals(playerName: "Daniel", time: "18:29"),
            Goals(playerName: "Sophia", time: "25:03"),
            Goals(playerName: "David", time: "31:55")
        ]
        let score3 = Score(whiteTeamPoints: 5, blackTeamPoints: 0)
        let game3 = Game(score: score3, gameDate: "2023-06-12", goals: goals3)

        let goals4: [Goals] = [
            Goals(playerName: "Sarah", time: "5:47"),
            Goals(playerName: "John", time: "10:19"),
            Goals(playerName: "Olivia", time: "16:55")
        ]
        let score4 = Score(whiteTeamPoints: 3, blackTeamPoints: 0)
        let game4 = Game(score: score4, gameDate: "2023-06-19", goals: goals4)
        
        let goals5: [Goals] = [
            Goals(playerName: "Michael", time: "7:31"),
            Goals(playerName: "Sophia", time: "14:58"),
            Goals(playerName: "Daniel", time: "23:10"),
            Goals(playerName: "Robert", time: "29:45")
        ]
        let score5 = Score(whiteTeamPoints: 4, blackTeamPoints: 0)
        let game5 = Game(score: score5, gameDate: "2023-06-26", goals: goals5)

        completion([game1, game2, game3, game4, game5])
    }
    
}
