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
    let sender: User
    let text: String
    let timestamp: Date
}
