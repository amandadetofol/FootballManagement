//
//  FinancialPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 12/06/23.
//

import Foundation
import FirebaseFirestore

protocol FinancialViewProtocol: AnyObject {
    func updateViewForPayed()
    func updateViewForPendencie()
    func updateView(with model: [FinancialPendencieCardViewModel])
}

final class FinancialPresenter: FinancialPendenciesPresenterProtocol {
    
    weak var view: FinancialViewProtocol?
    
    func updateView(basedOn selectIndex: Int) {
        switch selectIndex {
            case 1:
                view?.updateViewForPayed()
            case 0:
                view?.updateViewForPendencie()
            default:
                return
        }
    }
    
    func updateView(with model: [QueryDocumentSnapshot]?) {
        let viewModel = parseFirebaseSnapshotToFinancialPendenciesCardViewModel(model: model)
        view?.updateView(with: viewModel)
    }
    
    //MARK: Private methods
    private func parseFirebaseSnapshotToFinancialPendenciesCardViewModel(model: [QueryDocumentSnapshot]?) -> [FinancialPendencieCardViewModel] {
        guard let model = model else { return [] }
        return model.enumerated().map({ (index, model) in
            FinancialPendencieCardViewModel(
                title: model["title"] as? String ?? "",
                isLate: model["isLate"] as? Bool ?? Bool(),
                initialValue: model["initialValue"] as? Float ?? 0.0,
                numberOfDaysLate: model["numberOfDaysLate"] as? Int ?? 0,
                hasProof: model["hasProof"] as? Bool ?? false,
                proofUrl: model["proofUrl"] as? String,
                id: index+1,
                reason: model["reason"] as? String ?? "")
        })
    }
    
}
