//
//  FinancialAdministratorMainViewModel.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 14/08/23.
//

import Foundation

enum FinancialAdministratorActions: String {
    case history = "Histórico"
    case pendencies = "Pendencias"
    case newCredit = "Novo Crédito"
    case newDebit = "Novo Débito"
    
    var description: String {
        switch self {
        case .history:
            return "Histórico de finanças do time"
        case .pendencies:
            return "Pagamentos pendentes"
        case .newCredit:
            return "Creditar valor em conta"
        case .newDebit:
            return "Debitar valor em conta"
        }
    }
}

struct FinancialAdministratorMainViewModel {
    let username: String
    let balance: String
    let items: [FinancialAdministratorActions] = [
            .history,
            .pendencies,
            .newCredit,
            .newDebit]
}
