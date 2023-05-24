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
    let warnings: [UserWarning]?
    let isAdm: Bool
}

struct UserWarning {
    let title: String
    let description: String
    let firstActionTitle: String 
    let firstActionKey: InternalLinkRedirectKeys
}
