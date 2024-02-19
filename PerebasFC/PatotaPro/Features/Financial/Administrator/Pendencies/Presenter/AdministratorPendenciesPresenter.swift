//
//  AdministratorPendenciesPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 19/08/23.
//

import Foundation
import FirebaseFirestore

protocol FinancialAdministratorPresenterProtocol {
    func updateView(with model: [DocumentSnapshot])
    func updateView(basedOn segmentedControlIndex: Int)
}

protocol FinancialAdministratorViewProtocol: AnyObject {
    func updateView(with model: AdministratorPendenciesViewModel)
    func updateView(basedOn segmentedControlIndex: Int)
}

final class AdministratorPendenciesPresenter: FinancialAdministratorPresenterProtocol {
    
    weak var view: FinancialAdministratorViewProtocol?
    
    func updateView(with model: [DocumentSnapshot]){
        view?.updateView(with: parseQuerySnapshotIntoAdministratorPendenciesViewModel(model: model))
    }
    
    func updateView(basedOn segmentedControlIndex: Int){
        view?.updateView(basedOn: segmentedControlIndex)
    }
    
    private func parseQuerySnapshotIntoAdministratorPendenciesViewModel(model: [DocumentSnapshot]) -> AdministratorPendenciesViewModel {
        
        var items: [FinancialAdministratorPendenciesListCardModel] = []
        
        model.forEach { document in
            
            if !(document["admAprooved"] as? Bool ?? false) {
                items.append(
                    FinancialAdministratorPendenciesListCardModel(
                        title: document["title"] as? String ?? "",
                        value: "\(document["expectedValue"] as? Int ?? 0)",
                        name: document["reason"] as? String ?? "",
                        daysLate: document["numberOfDaysLate"] as? Int ?? 0,
                        proofUrl: document["proofUrl"] as? String ?? "",
                        userName: document["userName"] as? String ?? "",
                        id: document.documentID)
                )
            }
        }
        
        return AdministratorPendenciesViewModel(items: items)
    }
    
}
