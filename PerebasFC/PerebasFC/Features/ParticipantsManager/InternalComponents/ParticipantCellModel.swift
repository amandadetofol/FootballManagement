//
//  ParticipantCellModel.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/08/23.
//

import Foundation

struct ParticipantCellModel {
    
    var name: String {
        get {
            guard let user = user else { return "" }
            return user.firstName + user.lastName
        }
    }
    
    var position: String {
        get {
            guard let user = user else { return "" }
            return user.position
        }
    }
    
    let user: User?
}
