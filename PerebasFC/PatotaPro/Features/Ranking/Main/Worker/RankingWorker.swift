//
//  RankingWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import Foundation
import FirebaseFirestore

protocol RankingWorkerProtocol {
    func getPrices(_ completion: @escaping((DocumentSnapshot?)->Void))
    func getRanking(_ completion: @escaping ((QuerySnapshot?) -> Void))
}

final class RankingWorker: RankingWorkerProtocol {

    private let firebaseUsersProvider = Firestore.firestore().collection("\(Session.shared.teamId ?? "")")
    private let firebaseFirestoreRankingPriceProvider = Firestore.firestore().document("\(Session.shared.teamId ?? "")/ranking/team/price")
    
    func getPrices(_ completion: @escaping((DocumentSnapshot?)->Void)) {
        firebaseFirestoreRankingPriceProvider.getDocument { parseDocumentSnapshot, error in
            guard error == nil else {
                completion(nil)
                return
            }
            completion(parseDocumentSnapshot)
        }
    }
    
    func getRanking(_ completion: @escaping ((QuerySnapshot?) -> Void)) {
        firebaseUsersProvider.getDocuments { querySnapshot, error in
            guard error == nil else {
                completion(nil)
                return
            }
            completion(querySnapshot)
        }
    }
    
}
