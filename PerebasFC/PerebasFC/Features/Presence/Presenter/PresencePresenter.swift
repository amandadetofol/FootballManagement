//
//  PresencePresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/09/23.
//

import Foundation
import FirebaseFirestore

protocol PresencePresenterProtocol {
    func updateView(with model: QuerySnapshot, hasComeFromGamesDatabase: Bool)
}

protocol PresenceViewProtocol: AnyObject {
    func updateView(with model: [PresenceCardViewModel])
}

final class PresencePresenter: PresencePresenterProtocol {
    
    weak var view: PresenceViewProtocol?
    
    func updateView(with model: QuerySnapshot, hasComeFromGamesDatabase: Bool){
        view?.updateView(
            with: parseQuerySnapShotIntoModel(
                querySnapShot: model,
                hasComeFromGamesDataBase: hasComeFromGamesDatabase))
    }
    
    //MARK: Private methods
    private func parseQuerySnapShotIntoModel(
        querySnapShot: QuerySnapshot,
        hasComeFromGamesDataBase: Bool) -> [PresenceCardViewModel]{
            if hasComeFromGamesDataBase {
                return querySnapShot.documents.enumerated().map { (index, item) in
                    PresenceCardViewModel(
                        name: item["name"] as? String ?? "",
                        wasPresent: item["waspresent"] as? Bool ?? false,
                        currentIndex: index+1,
                        total: querySnapShot.documents.count)
                
                }
            } else {
                return querySnapShot.documents.enumerated().map { (index, item) in
                    PresenceCardViewModel(
                        name: item["name"] as? String ?? "",
                        wasPresent: true,
                        currentIndex: index+1,
                        total: querySnapShot.documents.count)
                
                }
            }
            
    }
    
}
