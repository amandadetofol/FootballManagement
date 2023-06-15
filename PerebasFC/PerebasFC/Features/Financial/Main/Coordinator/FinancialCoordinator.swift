//
//  FinancialCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 12/06/23.
//

import UIKit

protocol FinancialCoordinatorProtocol {
    func gotoFinancialDetails(with model: FinancialPendencieCardViewModel)
}

final class FinancialCoordinator: FinancialCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func gotoFinancialDetails(with model: FinancialPendencieCardViewModel){
        if model.hasProof && !model.isLate {
            navigationController.pushViewController(
                SeeProofWebViewController(url: model.proofUrl ?? ""),
                animated: true)
        } else {
            navigationController.pushViewController(
                FinancialDetailsFactory.getFinancialDetailsViewController(
                    model: FinancialDetailsViewModel(
                        informativeText: "Existem alguns fatores que podem impactar no valor dos itens como: dias em atraso e número de faltas nos últimos jogos (com e sem aviso prévio).",
                        disclaimer: PendenciesDisclaimerViewModel(
                            itemName: model.title,
                            initialValue: String(model.initialValue),
                            daysLate: String(model.numberOfDaysLate ?? 0),
                            otherReason: nil,
                            totalValue: String(model.initialValue)),
                        actionTitle: "adicionar um comprovante".uppercased())),
                animated: true)
        }
    }
    
}
