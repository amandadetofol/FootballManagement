//
//  UserModel.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 22/05/23.
//

import Foundation

struct User {
    let firstName: String
    let lastName: String
    let warnings: [UserWarnings]?
    let isAdm: Bool
}

struct UserWarnings {
    let title: String
    let description: String
    let firstActionKey: InternalLinkRedirectKeys
    let secondActionKey: InternalLinkRedirectKeys
}
