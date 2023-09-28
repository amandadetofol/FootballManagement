//
//  SortMainWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/08/23.
//

import Foundation
import FirebaseFirestore

protocol SortMainWorkerProtocol {
    func getSorts(completion: @escaping((SortGameMainViewModel)->Void))
    func handleNewSort(completion: @escaping(([User]?, [User]?)-> Void))
}

final class SortMainWorker: SortMainWorkerProtocol {
    
    private let fireabaseFirestoreProvider = Firestore.firestore()
    
    func handleNewSort(completion: @escaping(([User]?, [User]?)-> Void)) {
        fireabaseFirestoreProvider.collection("perebasfc").getDocuments { [weak self] documents, error in
            guard error == nil,
                  let documents = documents,
                  let self = self else {
                completion(nil, nil)
                return
            }
        
            let userArray = self.getUsers(with: documents).shuffled()
            let whiteTeam = Array(userArray.prefix(userArray.count / 2))
            let blackTeam = Array(userArray.suffix(userArray.count / 2))
        
            whiteTeam.forEach { user in
                self.fireabaseFirestoreProvider
                    .document("sort/whiteteam/\(Date())/\(user.email ?? "")")
                    .setData(
                        ["name" : user.firstName,
                         "lastName" : user.lastName,
                         "shirtNumber" : user.shirtNumber,
                         "rankingPlace": user.rankingPosition ?? 0
                         ])
            }
           
            blackTeam.forEach { user in
                self.fireabaseFirestoreProvider
                    .document("sort/blackteam/\(Date())/\(user.email ?? "")")
                    .setData(
                        ["name" : user.firstName,
                         "lastName" : user.lastName,
                         "shirtNumber" : user.shirtNumber,
                         "rankingPlace": user.rankingPosition ?? 0
                         ])
            }
            
            completion(whiteTeam, blackTeam)
        }
     
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
                            blackTeam: Team(players: Session.shared.players)),
                        total: 2,
                        currentIndex: 1),
                        SortCardViewModel(
                            title: "Sorteio 01",
                            description: "Expirado",
                            model: WeekTeamViewModel(
                                whiteTeam: Team(players: Session.shared.players),
                                blackTeam: Team(players: Session.shared.players)),
                            total: 2,
                            currentIndex: 2)
                    ]))
    }
    
    //MARK: Private methods
    private func getUsers(with model: QuerySnapshot) -> [User] {
        var users: [User] = []
        model.documents.forEach { document in
            users.append(
                User(
                firstName: document["name"] as? String ?? "",
                lastName: document["lastname"] as? String ?? "",
                shirtNumber: document["shirtNumber"] as? String ?? "",
                position: document["position"] as? String ?? "",
                team: document["team"] as? String ?? "",
                warning: nil,
                rankingPosition: document["rankingPlace"] as? Int ?? 0,
                isAdm: Session.shared.isAdm ?? false,
                type: ParticipantType(rawValue: document["type"] as? String ?? "") ?? .player,
                menuItems: nil,
                email: document["email"] as? String ?? "",
                category: document["category"] as? String ?? "")
            )
        }
        return users
    }
    
}
