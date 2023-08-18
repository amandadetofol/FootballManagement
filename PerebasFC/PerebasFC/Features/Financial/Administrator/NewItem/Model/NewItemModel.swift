//
//  NewItemModel.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 17/08/23.
//

import Foundation

struct NewItemModel {
    let eventName: String
    let eventValue: String
    let date: Date
    let type: NewItemType
    let splitBeetweenTeamMember: Bool?
}

enum NewItemType: String {
    case credit = "Adicionar crédito saldo na conta do time."
    case debit = "Adicionar débito na conta do time. Ao marcar o switch 'Dividir o valor entre membros do time' o valor do débito será incluído como uma pendência para todos os participantes do time."
}
