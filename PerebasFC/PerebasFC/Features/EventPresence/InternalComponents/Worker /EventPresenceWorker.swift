//
//  EventPresenceWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/09/23.
//

import Foundation

protocol EventPresenceWorkerProtocol {
    func getEventPresenceModel(completion: @escaping(([EventPresenceCardViewModel]) -> Void))
}

final class EventPresenceWorker: EventPresenceWorkerProtocol {
    
    
    func getEventPresenceModel(completion: @escaping (([EventPresenceCardViewModel]) -> Void)) {
        completion(getMock())
    }
    
}

extension EventPresenceWorker {
    
    private func getMock() -> [EventPresenceCardViewModel] {
    
        let eventPresenceCardViewModel1 = EventPresenceCardViewModel(name: "John Doe", companieNumber: 1234, currentIndex: 1, total: 10)

        let eventPresenceCardViewModel2 = EventPresenceCardViewModel(name: "Alice Smith", companieNumber: nil, currentIndex: nil, total: nil)

        let eventPresenceCardViewModel3 = EventPresenceCardViewModel(name: "Bob Johnson", companieNumber: 5678, currentIndex: 5, total: 20)

        let eventPresenceCardViewModel4 = EventPresenceCardViewModel(name: "Eva Williams", companieNumber: nil, currentIndex: 3, total: 8)

        let eventPresenceCardViewModel5 = EventPresenceCardViewModel(name: "Michael Brown", companieNumber: 9876, currentIndex: nil, total: 15)

        let eventPresenceCardViewModel6 = EventPresenceCardViewModel(name: "Sophia Davis", companieNumber: 4321, currentIndex: 2, total: 12)

        let eventPresenceCardViewModel7 = EventPresenceCardViewModel(name: "David Lee", companieNumber: nil, currentIndex: nil, total: nil)

        let eventPresenceCardViewModel8 = EventPresenceCardViewModel(name: "Olivia Hall", companieNumber: 8765, currentIndex: 7, total: 25)

        let eventPresenceCardViewModel9 = EventPresenceCardViewModel(name: "William Miller", companieNumber: nil, currentIndex: 4, total: 10)

        let eventPresenceCardViewModel10 = EventPresenceCardViewModel(name: "Emma Wilson", companieNumber: 3456, currentIndex: 6, total: 18)

        return [
            eventPresenceCardViewModel1,
            eventPresenceCardViewModel2,
            eventPresenceCardViewModel3,
            eventPresenceCardViewModel4,
            eventPresenceCardViewModel5,
            eventPresenceCardViewModel6,
            eventPresenceCardViewModel7,
            eventPresenceCardViewModel8,
            eventPresenceCardViewModel9,
            eventPresenceCardViewModel10]
    }
    
}
