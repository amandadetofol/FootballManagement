//
//  ChatItemViewModel.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 09/06/23.
//

import Foundation

struct ChatItemViewModel {
    let initials: String
    let fullName: String
    let lastMessagePartialDescription: String
    let shouldShowNotificationsLabel: Bool
    let numberOfNotifications: Int
    let chat: [Chat]
}

struct Chat {
    let messageId: String
    let sender: UserChat
    let text: String
    let timestamp: Date
    let myId: String 
    var wasRead: Bool = false
   
    var isMyMessage: Bool {
        get { return sender.id != myId }
    }
}

struct UserChat {
    let id: String
    let fullName: String 
}
