//
//  GamesHistoryPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 30/05/23.
//

import Foundation
import FirebaseFirestore

protocol GamesHistoryViewProtocol: AnyObject {
    func updateView(using model: [Game])
}

final class GamesHistoryPresenter: GamesHistoryPresenterProtocol {
    
    weak var view: GamesHistoryViewProtocol?
    
    func updateView(using model: QuerySnapshot) {
        view?.updateView(using: parseQuerySnapshotIntoGameList(model: model))
    }
    
    //MARK: Private methods
    private func parseQuerySnapshotIntoGameList(model: QuerySnapshot) -> [Game] {
        model.documents.map { document in
            let whiteGoals = document["whiteTeamGoals"] as? [String] ?? []
            let blackGoals = document["blackTeamGoals"] as? [String] ?? []
            var goals: [Goals] = []
            
            for indice in stride(from: 0, to: whiteGoals.count, by: 2) {
                let elemento1 = whiteGoals[indice]
                
                if indice + 1 < whiteGoals.count {
                    let elemento2 = whiteGoals[indice + 1]
                    goals.append(
                        Goals(
                            player: elemento1,
                            time: elemento2 as? Date ?? Date(),
                            index: indice,
                            isWhiteTeam: true))
                }
            }
            
            for indice in stride(from: 0, to: blackGoals.count, by: 2) {
                let elemento1 = blackGoals[indice]
                
                if indice + 1 < blackGoals.count {
                    let elemento2 = blackGoals[indice + 1]
                    goals.append(
                        Goals(
                            player: elemento1,
                            time: elemento2 as? Date ?? Date(),
                            index: indice,
                            isWhiteTeam: false))
                }
            }
            
            return Game(score: Score(
                whiteTeamPoints: document["whiteTeam"] as? Int ?? 0,
                blackTeamPoints: document["blackTeam"] as? Int ?? 0),
                        gameDate: document.documentID,
                        goals: goals,
                        date: converterStringParaData(document.documentID, formato: "dd/MM/yyyy HH:mm:ss") ?? Date())
        }
    }
    
    
    func converterStringParaData(_ dataString: String, formato: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formato
        dateFormatter.locale = Locale(identifier: "pt_BR") // Define o local desejado, se necessário
        
        return dateFormatter.date(from: dataString)
    }
}
