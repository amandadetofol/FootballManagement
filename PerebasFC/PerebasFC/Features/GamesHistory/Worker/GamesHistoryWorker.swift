//
//  GamesHistoryWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 30/05/23.
//

import UIKit

protocol GamesHistoryWorkerProtocol {
    func getGamesHistory(_ completion: @escaping (([Game]?) -> Void))
}

final class GamesHistoryWorker: GamesHistoryWorkerProtocol {
    
    func getGamesHistory(_ completion: @escaping (([Game]?) -> Void)) {
        let userWarning = UserWarning(
            title: "Warning Title",
            description: "Warning Description",
            icon: UIImage(),
            firstActionTitle: "Take Action",
            firstActionKey: .chat
        )

        let user = User(
            id: "123",
            firstName: "John",
            lastName: "Doe",
            shirtNumber: "10",
            position: "Forward",
            team: "FC Barcelona",
            warning: userWarning,
            rankingPosition: 5,
            isAdm: true,
            menuItems: [MenuItemViewModel(title: String(), icon: UIImage(), redirectKey: .calendar)]
        )

        let goals1: [Goals] = [
            Goals( player: user, time: Date(), index: 1),
            Goals( player: user, time: Date(), index: 2),
            Goals( player: user, time: Date(), index: 3)
        ]
        let score1 = Score(whiteTeamPoints: 2, blackTeamPoints: 1)
        let game1 = Game(score: score1, gameDate: "2023-05-29", goals: goals1, date: Date())

        let goals2: [Goals] = [
            Goals( player: user, time: Date(), index: 1),
            Goals( player: user, time: Date(), index: 2),
            Goals( player: user, time: Date(), index: 3)
        ]
        let score2 = Score(whiteTeamPoints: 0, blackTeamPoints: 3)
        let game2 = Game(score: score2, gameDate: "2023-06-05", goals: goals2, date: Date())

        let goals3: [Goals] = [
            Goals( player: user, time: Date(), index: 1),
            Goals( player: user, time: Date(), index: 2),
            Goals( player: user, time: Date(), index: 3)
        ]
        let score3 = Score(whiteTeamPoints: 3, blackTeamPoints: 0)
        let game3 = Game(score: score3, gameDate: "2023-06-12", goals: goals3, date: Date())

        completion([game1, game2, game3])
    }
    
}
