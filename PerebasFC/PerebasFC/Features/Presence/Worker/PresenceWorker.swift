//
//  PresenceWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/09/23.
//

import Foundation

protocol PresenceWorkerProtocol {
    func getUsers(completion: @escaping (([PresenceCardViewModel]) -> Void ))
}

final class PresenceWorker: PresenceWorkerProtocol {
    
    func getUsers(completion: @escaping (([PresenceCardViewModel]) -> Void)) {
        completion(getMock())
    }

}

extension PresenceWorker {
    
    private func getMock() -> [PresenceCardViewModel] {
        let mock1 = PresenceCardViewModel(name: "João", wasPresent: true, currentIndex: 1, total: 5)
        let mock2 = PresenceCardViewModel(name: "Maria", wasPresent: false, currentIndex: nil, total: nil)
        let mock3 = PresenceCardViewModel(name: "Pedro", wasPresent: true, currentIndex: 2, total: 3)
        let mock4 = PresenceCardViewModel(name: "Ana", wasPresent: true, currentIndex: 3, total: 3)
        let mock5 = PresenceCardViewModel(name: "Luís", wasPresent: false, currentIndex: nil, total: 7)
        let mock6 = PresenceCardViewModel(name: "Carla", wasPresent: true, currentIndex: 1, total: 1)
        let mock7 = PresenceCardViewModel(name: "Miguel", wasPresent: false, currentIndex: nil, total: 10)
        let mock8 = PresenceCardViewModel(name: "Sofia", wasPresent: true, currentIndex: 5, total: 5)
        let mock9 = PresenceCardViewModel(name: "Ricardo", wasPresent: false, currentIndex: nil, total: nil)
        let mock10 = PresenceCardViewModel(name: "Lúcia", wasPresent: true, currentIndex: 4, total: 4)

        return [mock1, mock2, mock3, mock4, mock5, mock6, mock7, mock9, mock10, mock1, mock2, mock3, mock4, mock5, mock6, mock7, mock9, mock10]
    }
    
}
