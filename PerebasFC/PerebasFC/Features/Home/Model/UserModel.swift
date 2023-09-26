//
//  UserModel.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 22/05/23.
//

import UIKit

struct User {
    let firstName: String
    let lastName: String
    let shirtNumber: String
    let position: String
    let team: String 
    let warning: UserWarning?
    let rankingPosition: Int? 
    let isAdm: Bool
    let type: ParticipantType
    let menuItems: [MenuItemViewModel]?
    var email: String? = nil 
}

struct UserWarning {
    let title: String
    let description: String
    let icon: UIImage
    let firstActionTitle: String 
    let firstActionKey: InternalLinkRedirectKeys
}
