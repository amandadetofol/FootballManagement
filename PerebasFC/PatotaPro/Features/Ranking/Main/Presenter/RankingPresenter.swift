//
//  RankingPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import UIKit
import FirebaseFirestore

protocol RankingViewProtocol: AnyObject {
    func updateView(with model: RankingViewModel)
    func updateViewForPricesErrorState()
    func updateView(with firebaseDocumentSnapshot: FirstPlaceGiftsViewModel)
    func showUnsufficentPlayersMessage()
}

final class RankingPresenter: RankingPresenterProtocol {
    
    weak var view: RankingViewProtocol?
    
    func updateView(with model: QuerySnapshot) {
        guard let viewModel = parseQuerySnapshotIntoRankingViewModel(model: model) else { return }
        view?.updateView(with: viewModel)
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
    private func parseQuerySnapshotIntoRankingViewModel(model : QuerySnapshot) -> RankingViewModel? {
        var firstPlaceModel: BarAndTrophyViewModel? = nil
        var secondPlaceModel: BarAndTrophyViewModel? = nil
        var thirdPlaceModel: BarAndTrophyViewModel? = nil
        var others: [CommonnPlacesViewModel]? = []
        
        var items = model.documents
        items.sort { (item1, item2) in
            if let rank1 = item1["rankingPlace"] as? Float, let rank2 = item2["rankingPlace"] as? Float {
                return rank1 < rank2
            }
            return false
        }
        
        if items.count >= 3 {
            firstPlaceModel = parseDocumentSnapshotIntoBarAndTrophyViewModel(
                documentSnapshot: items[0],
                place: 1)

            secondPlaceModel = parseDocumentSnapshotIntoBarAndTrophyViewModel(
                documentSnapshot: items[1],
                place: 2)
       
            thirdPlaceModel = parseDocumentSnapshotIntoBarAndTrophyViewModel(
                documentSnapshot: items[2],
                place: 3)
            
        } else {
            DispatchQueue.main.async {
                self.view?.showUnsufficentPlayersMessage()
            }
            return nil
        }
        
        for document in 3..<items.count {
            others?.append(
                CommonnPlacesViewModel(
                    name: items[document]["name"] as? String ?? "",
                    postion: Int(items[document]["rankingPlace"] as? Float ?? 0.0),
                    wentUp: items[document]["goUpInRanking"] as? Bool ?? false))
        }
        
        guard let firstPlaceModel,
              let secondPlaceModel,
              let thirdPlaceModel,
              var others else {
            return nil
        }
        
        others = others.sorted { $0.postion < $1.postion }
        
        return RankingViewModel(
            firstPlaceModel: firstPlaceModel,
            secondPlaceModel: secondPlaceModel,
            thirdPlaceModel: thirdPlaceModel,
            otherParticipants: others)
    }
    
    private func parseDocumentSnapshotIntoBarAndTrophyViewModel(
        documentSnapshot: DocumentSnapshot,
        place: Int) -> BarAndTrophyViewModel? {
            guard let name = documentSnapshot["name"] as? String,
                  let lastName = documentSnapshot["lastname"] as? String else {
                return nil
            }
            
            return BarAndTrophyViewModel(
                initials: "\(name.first ?? Character(" "))\(lastName.first ?? Character(" "))".uppercased(),
                postiionLabel: place,
                barColor: getColor(basedOn: place),
                trophyColor: getColor(basedOn: place))
        }
    
    private func getColor(basedOn rankingPosition: Int) -> UIColor {
        switch rankingPosition {
        case 1:
            return UIColor.gold
        case 2:
            return UIColor.silver
        case 3:
            return UIColor.browned
        default:
            return UIColor.black
        }
    }
    
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
