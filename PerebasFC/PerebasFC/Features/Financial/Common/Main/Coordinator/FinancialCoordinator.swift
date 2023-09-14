//
//  FinancialCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 12/06/23.
//

import UIKit

protocol FinancialCoordinatorProtocol {
    func showLoading()
    func removeLoading()
    func gotoFinancialDetails(with model: FinancialPendencieCardViewModel)
}

final class FinancialCoordinator: FinancialCoordinatorProtocol {
    
    private let loader: LoaderCoodinator
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.loader = LoaderCoodinator(navigationController: navigationController)
        self.navigationController = navigationController
    }
    
    func gotoFinancialDetails(with model: FinancialPendencieCardViewModel){
        if model.hasProof && !model.isLate {
            guard let url = URL(string: model.proofUrl ?? "") else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            navigationController.pushViewController(
                FinancialDetailsFactory.getFinancialDetailsViewController(
                    model: FinancialDetailsViewModel(
                        informativeText: "Existem alguns fatores que podem impactar no valor dos itens como: dias em atraso e número de faltas nos últimos jogos (com e sem aviso prévio).",
                        disclaimer: PendenciesDisclaimerViewModel(
                            itemName: model.title,
                            initialValue: model.initialValue,
                            daysLate: model.numberOfDaysLate ?? 0,
                            otherReason: nil),
                        actionTitle: "adicionar um comprovante".uppercased(),
                        index: model.id),
                    navigationController: navigationController),
                animated: true)
        }
    }
    
    func showLoading(){
        loader.showLoader()
    }
    
    func removeLoading(){
        loader.removeLoader()
    }
    
}
