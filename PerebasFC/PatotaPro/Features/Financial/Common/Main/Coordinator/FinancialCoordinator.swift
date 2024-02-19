//
//  FinancialCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 12/06/23.
//

import UIKit

protocol FinancialCoordinatorProtocol {
    func showLoading(_ completion: @escaping(()->Void))
    func removeLoading(_ completion: @escaping(()->Void))
    func showEmptyAlert()
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
                        actionTitle: "Adicionar um comprovante",
                        index: model.id),
                    navigationController: navigationController),
                animated: true)
        }
    }
    
    func showLoading(_ completion: @escaping(()->Void)){
        loader.showLoader(completion)
    }
    
    func removeLoading(_ completion: @escaping(()->Void)){
        loader.removeLoader(completion)
    }
    
    func showEmptyAlert(){
        let alert = UIAlertController(
            title: "Nenhum dado encontrado!",
            message: "Não se preocupe, assim que o administrador adicionar uma pendencia ou um crédito ele aparecerá aqui.",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default))
        navigationController.present(
            alert,
            animated: true)
    }
    
}
