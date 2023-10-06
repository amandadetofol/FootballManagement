//
//  GamesHistoryWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 30/05/23.
//

import UIKit
import FirebaseFirestore

protocol GamesHistoryWorkerProtocol {
    func addNewGame(
        game: Game,
        completion: @escaping((Bool)->Void))
    func getGamesHistory(_ completion: @escaping ((QuerySnapshot?) -> Void))
    func getParticipants(completion: @escaping((QuerySnapshot?) -> Void))
}

final class GamesHistoryWorker: GamesHistoryWorkerProtocol {
    
    private let firebaseFirestoreProvider = Firestore.firestore()
    private let usersFirebaseReference = Firestore.firestore().collection("perebasfc")
    var goals: [Game] = []
    
    func getParticipants(completion: @escaping ((QuerySnapshot?) -> Void)) {
        usersFirebaseReference.getDocuments { querySnapshot, error in
            guard error == nil else {
                completion(nil)
                return
            }
            completion(querySnapshot)
        }
    }
    
    func getGamesHistory(_ completion: @escaping ((QuerySnapshot?) -> Void)) {
        firebaseFirestoreProvider.collection("gamelist").getDocuments { querySnapShot, error in
            guard error == nil,
                  let querySnapShot else {
                completion(nil)
                return
            }
            
            completion(querySnapShot)
        }
    }
    
    func addNewGame(
        game: Game,
        completion: @escaping((Bool)->Void)) {
            var whiteTeamGoals: [String] = []
            var blackTeamGoals: [String] = []
            
            game.goals?.forEach({ goal in
                if goal.isWhiteTeam {
                    whiteTeamGoals.append(goal.player)
                    whiteTeamGoals.append(goal.time.toString())
                } else {
                    blackTeamGoals.append(goal.player)
                    blackTeamGoals.append(goal.time.toString())
                }
            })
            
            firebaseFirestoreProvider.document("gamelist/\(game.gameDate.replacingOccurrences(of: "/", with: "-"))").setData([
                "blackTeam": game.score?.blackTeamPoints ?? 0,
                "whiteTeam": game.score?.whiteTeamPoints ?? 0,
                "totalGoals": game.goals?.count ?? 0,
                "blackTeamGoals": whiteTeamGoals,
                "whiteTeamGoals": blackTeamGoals,
            ])
            
            completion(true)
    }

    
}
