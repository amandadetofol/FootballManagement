//
//  RankingPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import Foundation
import FirebaseFirestore

protocol RankingViewProtocol: AnyObject {
    func updateView(with model: RankingViewModel)
    func updateViewForPricesErrorState()
    func updateView(with firebaseDocumentSnapshot: FirstPlaceGiftsViewModel)
}

final class RankingPresenter: RankingPresenterProtocol {
    
    weak var view: RankingViewProtocol?
    
    func updateView(with model: RankingViewModel) {
        view?.updateView(with: model)
    }
    
    func updatePricesWith(with model: DocumentSnapshot?){
        guard let model,
              let viewModel = parseDocumentSnapshotIntoPricesViewModel(model: model) else {
            view?.updateViewForPricesErrorState()
            return
        }
        
        view?.updateView(with: viewModel)
    }
    
    //MARK: Private methods
    private func parseDocumentSnapshotIntoPricesViewModel(model: DocumentSnapshot) -> FirstPlaceGiftsViewModel? {
        guard let pricesArray = model["prices"] as? [String] else {
            return nil
        }
        
        return FirstPlaceGiftsViewModel(
            first: pricesArray.first ?? "",
            second: pricesArray[1] ,
            third: pricesArray.last ?? "")
    }
    
}
