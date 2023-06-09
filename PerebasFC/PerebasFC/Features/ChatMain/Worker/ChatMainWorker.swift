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
                sender: UserChat(id: "03", fullName: "José Bezerra"),
                text: "Tudo bem?",
                timestamp: Date(),
                myId: "00")])
        
        let mock2 = ChatItemViewModel(
            initials: "MK",
            fullName: "Adrian Castro Mock 02",
            lastMessagePartialDescription: "Tudo bem?",
            shouldShowNotificationsLabel: true,
            numberOfNotifications: 1,
            chat: [Chat(
                messageId: "01",
                sender: UserChat(id: "03", fullName: "José Bezerra"),
                text: "Tudo bem?",
                timestamp: Date(),
                myId: "02")])
        
        let mock3 = ChatItemViewModel(
            initials: "MK",
            fullName: "Adrian Castro Mock 03",
            lastMessagePartialDescription: "Tudo bem?",
            shouldShowNotificationsLabel: true,
            numberOfNotifications: 1,
            chat: [Chat(
                messageId: "01",
                sender: UserChat(id: "03", fullName: "José Bezerra"),
                text: "Tudo bem?",
                timestamp: Date(),
                myId: "03")])
        
        completion([mock1, mock2, mock3])
    }
    
}
