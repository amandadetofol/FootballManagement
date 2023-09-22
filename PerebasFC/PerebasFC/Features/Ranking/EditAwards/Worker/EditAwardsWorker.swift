//
//  EditAwardsWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 22/09/23.
//

import Foundation
import FirebaseFirestore

protocol EditAwardsWorkerProtocol {
    func updateAwards(
        newAwards: FirstPlaceGiftsViewModel,
        completion: @escaping((Bool) -> Void))
}

final class EditAwardsWorker: EditAwardsWorkerProtocol {
    
    private let firebaseFirestoreRankingProvider = Firestore.firestore().collection("ranking").document("price")
    
    func updateAwards(
        newAwards: FirstPlaceGiftsViewModel,
        completion: @escaping((Bool) -> Void)) {
            let firebaseFormattedNewAwards = [newAwards.first, newAwards.second, newAwards.third]
            firebaseFirestoreRankingProvider.updateData([
                "prices" : firebaseFormattedNewAwards
            ], completion: { error in
                guard error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            })
        }
    
}
