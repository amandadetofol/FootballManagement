//
//  ParticipantsManagerWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/08/23.
//

import Foundation

protocol ParticipantsManagerWorkerProtocol {
    func getParticipants(completion: @escaping(([User]) -> Void))
}

final class ParticipantsManagerWorker: ParticipantsManagerWorkerProtocol {
    
    func getParticipants(completion: @escaping (([User]) -> Void)) {
        completion(Session.shared.players)
    }
    
}
