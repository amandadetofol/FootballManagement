//
//  ParticipantCellModel.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/08/23.
//

import Foundation

struct ParticipantCellModel {
    var total: Int? = nil
    var currentIndex: Int? = nil
    var name: String {
        get {
            guard let user = user else { return "" }
            return user.firstName
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
