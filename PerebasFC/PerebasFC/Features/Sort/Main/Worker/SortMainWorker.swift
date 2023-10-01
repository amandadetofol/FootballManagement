//
//  SortMainWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/08/23.
//

import Foundation
import FirebaseFirestore

protocol SortMainWorkerProtocol {
    func getSorts(completion: @escaping((SortFirebaseIncoming?)->Void))
    func handleNewSort(completion: @escaping(([User]?, [User]?)-> Void))
}

final class SortMainWorker: SortMainWorkerProtocol {
    
    private let fireabaseFirestoreProvider = Firestore.firestore()
    
    func handleNewSort(completion: @escaping(([User]?, [User]?)-> Void)) {
        fireabaseFirestoreProvider.document("sort/list").getDocument { [weak self] document, error in
            guard error == nil,
                  let self = self,
                  let document = document else {
                completion(nil, nil)
                return
            }
            
            guard var listOfSorts = document["list"] as? [String] else {
                completion(nil, nil)
                return
            }
            
            listOfSorts.removeAll { item in
                item.isEmpty
            }
            
            listOfSorts.forEach { sort  in
                self.fireabaseFirestoreProvider.document("sort/\(sort)").setData(["isActive": false])
            }
        }
        
        
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
            var whiteTeamDate: Date?
            var blackTeamDate: Date?
            
            whiteTeam.forEach { user in
                whiteTeamDate = Date()
                self.fireabaseFirestoreProvider
                    .document("sort/\(whiteTeamDate ?? Date())/whiteteam/\(user.email ?? "")")
                    .setData(
                        ["name" : user.firstName,
                         "lastName" : user.lastName,
                         "shirtNumber" : user.shirtNumber,
                         "rankingPlace": user.rankingPosition ?? 0
                        ])
            }
            
            blackTeam.forEach { user in
                blackTeamDate = Date()
                self.fireabaseFirestoreProvider
                    .document("sort/\(blackTeamDate ?? Date())/blackteam/\(user.email ?? "")")
                    .setData(
                        ["name" : user.firstName,
                         "lastName" : user.lastName,
                         "shirtNumber" : user.shirtNumber,
                         "rankingPlace": user.rankingPosition ?? 0
                        ])
            }
            
            self.fireabaseFirestoreProvider.document("sort/\(blackTeamDate ?? Date())").setData(["isActive": true])
            self.fireabaseFirestoreProvider.document("sort/\(blackTeamDate ?? Date())").updateData(["sortDate": blackTeamDate?.toString() ?? ""])
            
            self.fireabaseFirestoreProvider.document("sort/list").getDocument { document, error in
                guard let list = document?["list"] as? [String] else { return }
                var myList = list
                myList.append("\(blackTeamDate ?? Date())")
                self.fireabaseFirestoreProvider.document("sort/list").setData(["list" : myList])
            }
            
            completion(whiteTeam, blackTeam)
        }
        
    }
    
    func getSorts(completion: @escaping((SortFirebaseIncoming?)->Void)){
        fireabaseFirestoreProvider.document("sort/list").getDocument { [weak self] document, error in
            guard error == nil,
                  let self = self,
                  let document = document else {
                completion(nil)
                return
            }
            
            guard var listOfSorts = document["list"] as? [String] else {
                completion(nil)
                return
            }
            
            listOfSorts.removeAll { item in
                item.isEmpty
            }
            
            self.fetchData(listOfSorts: listOfSorts) { whiteTeams, blackTeams, others in
                completion(
                    SortFirebaseIncoming(
                        whiteTeam: whiteTeams,
                        blackTeam: blackTeams,
                        otherData: others))
            }
        }
    }
    
    //MARK: Private methods
    private func fetchData(
        listOfSorts: [String],
        completion: @escaping ([QuerySnapshot], [QuerySnapshot], [DocumentSnapshot]) -> Void) {
            let dispatchGroup = DispatchGroup()
            var whiteTeams: [QuerySnapshot] = []
            var blackTeams: [QuerySnapshot] = []
            var others: [DocumentSnapshot] = []
            
            for sort in listOfSorts {
                dispatchGroup.enter()
                
                self.fireabaseFirestoreProvider.document("sort/\(sort)").collection("whiteteam").getDocuments { querySnapshot, error in
                    defer {
                        dispatchGroup.leave()
                    }
                    
                    guard error == nil, let querySnapshot = querySnapshot else { return }
                    whiteTeams.append(querySnapshot)
                }
                
                dispatchGroup.enter()
                
                self.fireabaseFirestoreProvider.document("sort/\(sort)").collection("blackteam").getDocuments { querySnapshot, error in
                    defer {
                        dispatchGroup.leave()
                    }
                    
                    guard error == nil, let querySnapshot = querySnapshot else { return }
                    blackTeams.append(querySnapshot)
                }
                
                dispatchGroup.enter()
                
                self.fireabaseFirestoreProvider.document("sort/\(sort)").getDocument { documentSnapshot, error in
                    defer {
                        dispatchGroup.leave()
                    }
                    
                    guard error == nil, let documentSnapshot = documentSnapshot else { return }
                    others.append(documentSnapshot)
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(whiteTeams, blackTeams, others)
            }
        }
    
    
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
