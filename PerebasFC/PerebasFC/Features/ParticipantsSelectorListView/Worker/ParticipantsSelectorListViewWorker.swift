//
//  ParticipantsSelectorListViewWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 04/09/23.
//

import Foundation

protocol ParticipantsSelectorListViewWorkerProtocol {
    func getParticipants(completion: @escaping(([User])-> Void))
}

final class ParticipantsSelectorListViewWorker: ParticipantsSelectorListViewWorkerProtocol {
    
    func getParticipants(completion: @escaping (([User]) -> Void)) {
        let users = Session.shared.players
        completion(users)
    }
    
}
