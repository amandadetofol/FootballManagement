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
    func getRanking(_ completion: @escaping ((RankingViewModel?) -> Void))
}

final class RankingWorker: RankingWorkerProtocol {
    
    private let firebaseFirestoreRankingProvider = Firestore.firestore().collection("ranking").document("price")
    
    func getPrices(_ completion: @escaping((DocumentSnapshot?)->Void)) {
        firebaseFirestoreRankingProvider.getDocument { parseDocumentSnapshot, error in
            guard error == nil else {
                completion(nil)
                return
            }
            completion(parseDocumentSnapshot)
        }
    }
    
    func getRanking(_ completion: @escaping ((RankingViewModel?) -> Void)) {
       
        let rankingViewModelMock = RankingViewModel(
            firstPlaceModel: BarAndTrophyViewModel(
                initials: "JL",
                postiionLabel: 1,
                barColor: .gold,
                trophyColor: .gold
            ),
            secondPlaceModel: BarAndTrophyViewModel(
                initials: "KT",
                postiionLabel: 2,
                barColor: .gold,
                trophyColor: .silver
            ),
            thirdPlaceModel: BarAndTrophyViewModel(
                initials: "MS",
                postiionLabel: 3,
                barColor: .gold,
                trophyColor: .browned
            ),
            otherParticipants: [
                CommonnPlacesViewModel(
                    name: "Nome sobrenome",
                    postion: 4,
                    wentUp: false
                ),
                CommonnPlacesViewModel(
                    name: "Nome sobrenome",
                    postion: 5,
                    wentUp: true
                ),
                CommonnPlacesViewModel(
                    name: "Nome sobrenome",
                    postion: 6,
                    wentUp: false
                )
            ]
        )
        
        completion(rankingViewModelMock)
    }
    
}
