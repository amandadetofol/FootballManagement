//
//  SortMainWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/08/23.
//

import Foundation

protocol SortMainWorkerProtocol {
    func getSorts(completion: @escaping((SortGameMainViewModel)->Void))
    func handleNewSort(succeded: @escaping((Bool)-> Void))
}

final class SortMainWorker: SortMainWorkerProtocol {
    
    var shouldSucced = true
    
    func handleNewSort(succeded: @escaping ((Bool) -> Void)) {
        succeded(shouldSucced)
    }
    
    func getSorts(completion: @escaping((SortGameMainViewModel)->Void)){
        completion(
            SortGameMainViewModel(
                sorts: [
                    SortCardViewModel(
                        title: "Sorteio 02",
                        description: "Válido até 18/10",
                        model: WeekTeamViewModel(
                            whiteTeam: Team(players: Session.shared.players) ,
                            blackTeam: Team(players: Session.shared.players))),
                        SortCardViewModel(
                            title: "Sorteio 01",
                            description: "Expirado",
                            model: WeekTeamViewModel(
                                whiteTeam: Team(players: Session.shared.players),
                                blackTeam: Team(players: Session.shared.players)))
                    ]))
    }
    
}
