//
//  WeekTeamWithApiCallWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 01/10/23.
//

import Foundation
import FirebaseFirestore

protocol WeekTeamWithApiCallWorkerProtocol {
    func getCurrentAvailableSortedTeams(completion: @escaping((QuerySnapshot?, QuerySnapshot?) -> Void))
}

final class WeekTeamWithApiCallWorker: WeekTeamWithApiCallWorkerProtocol {
    
    private let firebaseFirestoreProvider = Firestore.firestore()
    
    func getCurrentAvailableSortedTeams(completion: @escaping((QuerySnapshot?, QuerySnapshot?) -> Void)){
        firebaseFirestoreProvider.document("sort/list").getDocument { [weak self] document, error in
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
            
            self.fetchData(listOfSorts: [listOfSorts.last ?? ""]) { whiteTeams, blackTeams, others in
                guard let whiteTeam = whiteTeams.first,
                      let blackTeam = blackTeams.first else {
                    completion(nil, nil)
                    return
                }
                        
                completion(whiteTeam, blackTeam)
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
                
                self.firebaseFirestoreProvider.document("sort/\(sort)").collection("whiteteam").getDocuments { querySnapshot, error in
                    defer {
                        dispatchGroup.leave()
                    }
                    
                    guard error == nil, let querySnapshot = querySnapshot else { return }
                    whiteTeams.append(querySnapshot)
                }
                
                dispatchGroup.enter()
                
                self.firebaseFirestoreProvider.document("sort/\(sort)").collection("blackteam").getDocuments { querySnapshot, error in
                    defer {
                        dispatchGroup.leave()
                    }
                    
                    guard error == nil, let querySnapshot = querySnapshot else { return }
                    blackTeams.append(querySnapshot)
                }
                
                dispatchGroup.enter()
                
                self.firebaseFirestoreProvider.document("sort/\(sort)").getDocument { documentSnapshot, error in
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
}
