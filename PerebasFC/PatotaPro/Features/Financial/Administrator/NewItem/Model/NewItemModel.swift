//
//  NewItemModel.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 17/08/23.
//

import Foundation

struct NewItemModel {
    var eventName: String
    var eventValue: String
    var date: Date
    var type: NewItemType
    var userEmail: String?
    var splitBeetweenTeamMember: Bool?
}

enum NewItemType: String {
    case credit = "Adicionar crédito saldo na conta do time."
    case debit = "Adicionar débito na conta do time. Ao marcar o switch 'Dividir o valor entre membros do time' o valor do débito será incluído como uma pendência para todos os participantes do time."
    
    var description: String {
        switch self {
        case .credit:
            return "Crédito"
        case .debit:
            return "Débito"
        }
    }
}
