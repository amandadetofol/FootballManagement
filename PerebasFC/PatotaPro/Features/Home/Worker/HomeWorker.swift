//
//  HomeWorker.swift
//  PatotaPro
//
//  Created by Amanda Detofol on 26/11/23.
//

import FirebaseFirestore

protocol HomeWorkerProtocol {
    func getTeamLogoAndHighlightColor(completion: @escaping((String?, String?)->Void))
}

final class HomeWorker: HomeWorkerProtocol {
    
    private let fireabaseFirestoreProvider = Firestore.firestore().document("team/\(Session.shared.teamId ?? "")")

    func getTeamLogoAndHighlightColor(completion: @escaping((String?, String?)->Void)){
        fireabaseFirestoreProvider.getDocument { document, error in
            guard let document,
                  error == nil else {
                completion(nil, nil)
                return
            }
            
            guard let imageUrl = document["image"] as? String,
                  let color = document["color"] as? String else {
                completion(nil, nil)
                return
            }
            
            completion(imageUrl, color)
        }
    }
    
}

