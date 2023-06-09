//
//  ChatMainWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 09/06/23.
//

import Foundation

protocol ChatMainWorkerProtocol {
    func getChat(completion: @escaping (([ChatItemViewModel]?) -> Void))
}

final class ChatMainWorker: ChatMainWorkerProtocol {
    
    func getChat(completion: @escaping (([ChatItemViewModel]?) -> Void)) {
        let mock1 = ChatItemViewModel(
            initials: "AC",
            fullName: "Adrian Castro",
            lastMessagePartialDescription: "Tudo bem?",
            shouldShowNotificationsLabel: true,
            numberOfNotifications: 1,
            chat: [Chat(
                messageId: "01",
                sender: User(
                    firstName: "John",
                    lastName: "Doe",
                    shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: []),
                text: "Tudo bem?",
                timestamp: Date())])
        
        let mock2 = ChatItemViewModel(
            initials: "MK",
            fullName: "Adrian Castro Mock 02",
            lastMessagePartialDescription: "Tudo bem?",
            shouldShowNotificationsLabel: true,
            numberOfNotifications: 1,
            chat: [Chat(
                messageId: "01",
                sender: User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: []),
                text: "Tudo bem?",
                timestamp: Date())])
        
        let mock3 = ChatItemViewModel(
            initials: "MK",
            fullName: "Adrian Castro Mock 03",
            lastMessagePartialDescription: "Tudo bem?",
            shouldShowNotificationsLabel: true,
            numberOfNotifications: 1,
            chat: [Chat(
                messageId: "01",
                sender: User(firstName: "John", lastName: "Doe", shirtNumber: "10", position: "Forward", team: "Red Team", warning: nil, rankingPosition: 1, isAdm: true, menuItems: []),
                text: "Tudo bem?",
                timestamp: Date())])
        
        completion([mock1, mock2, mock3])
    }
    
}
