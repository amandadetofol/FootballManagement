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
            
            updateItems(whiteTeamGoals: whiteTeamGoals, blackTeamGoals: blackTeamGoals)
            
            completion(true)
        }
    
    //MARK: Private func
    private func updateItems(
        whiteTeamGoals: [String],
        blackTeamGoals: [String]){
            updateGoalMakerRanking(whiteTeamGoals: whiteTeamGoals, blackTeamGoals: blackTeamGoals)
            if whiteTeamGoals.count > blackTeamGoals.count {
                updateWhiteTeamRanking(win: true)
                updateBlackTeamRanking(win: false)
            } else if whiteTeamGoals.count < blackTeamGoals.count {
                updateBlackTeamRanking(win: true)
                updateWhiteTeamRanking(win: false)
            } else {
                return
            }
    }
    
    private func updateGoalMakerRanking(
        whiteTeamGoals: [String],
        blackTeamGoals: [String]){
            let list = whiteTeamGoals + blackTeamGoals
            
            if list.isEmpty {
                return
            }
            
            usersFirebaseReference.whereField("name", in: list).getDocuments { documents, error in
                guard let documents,
                      error == nil else { return }
                
                documents.documents.forEach { document in
                    guard let rankingPosition = document["rankingPlace"] as? Double else { return }
                    if rankingPosition <= 1 { return }
                    Firestore.firestore().document("perebasfc/\(document.documentID)").updateData(["rankingPlace" : rankingPosition - 0.5])
                }
            }
    }
    
    private func updateWhiteTeamRanking(win: Bool){
        firebaseFirestoreProvider.document("sort/list").getDocument { [weak self] document, error in
            guard error == nil,
                  let self,
                  let document,
                  let listOfSorts = document["list"] as? [String],
                  let activeSort = listOfSorts.last else { return }
       
            self.firebaseFirestoreProvider.collection("sort/\(activeSort)/whiteteam").getDocuments { querySnapShot, error in
                guard let querySnapShot,
                      error == nil else { return }
                
                querySnapShot.documents.forEach { document in
                    self.usersFirebaseReference.document(document.documentID).getDocument { document, error in
                        guard let document,
                              error == nil else { return }
                        
                        guard let rankingPlace = document["rankingPlace"] as? Double else { return }
                        
                        if win {
                            Firestore.firestore().document("perebasfc/\(document.documentID)").updateData(["rankingPlace" : rankingPlace - 0.25])
                        } else {
                            Firestore.firestore().document("perebasfc/\(document.documentID)").updateData(["rankingPlace" : rankingPlace + 0.25])
                        }

                    }

                }
            }
        }
    }
    
    private func updateBlackTeamRanking(win: Bool){
        firebaseFirestoreProvider.document("sort/list").getDocument { [weak self] document, error in
            guard error == nil,
                  let self,
                  let document,
                  let listOfSorts = document["list"] as? [String],
                  let activeSort = listOfSorts.last else { return }
       
            self.firebaseFirestoreProvider.collection("sort/\(activeSort)/blackteam").getDocuments { querySnapShot, error in
                guard let querySnapShot,
                      error == nil else { return }
                
                querySnapShot.documents.forEach { document in
                    self.usersFirebaseReference.document(document.documentID).getDocument { document, error in
                        guard let document,
                              error == nil else { return }
                        
                        guard let rankingPlace = document["rankingPlace"] as? Double else { return }
                        
                        if win {
                            Firestore.firestore().document("perebasfc/\(document.documentID)").updateData(["rankingPlace" : rankingPlace - 0.25])
                        } else {
                            Firestore.firestore().document("perebasfc/\(document.documentID)").updateData(["rankingPlace" : rankingPlace + 0.25])
                        }

                    }

                }
            }
        }
    }
    
}
