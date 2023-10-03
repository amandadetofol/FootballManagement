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
        
        model.documents.forEach { document in
            guard let rankingPlace = document["rankingPlace"] as? Int else {
                return
            }
            
            if (rankingPlace >= 1) && (rankingPlace <= 3) {
                switch rankingPlace {
                case 1:
                    firstPlaceModel = parseDocumentSnapshotIntoBarAndTrophyViewModel(
                        documentSnapshot: document,
                        place: rankingPlace)
                case 2:
                    secondPlaceModel = parseDocumentSnapshotIntoBarAndTrophyViewModel(
                        documentSnapshot: document,
                        place: rankingPlace)
                case 3:
                    thirdPlaceModel = parseDocumentSnapshotIntoBarAndTrophyViewModel(
                        documentSnapshot: document,
                        place: rankingPlace)
                default:
                    break
                }
            } else {
                guard let name = document["name"] as? String,
                      let goUpInRanking = document ["goUpInRanking"] as? Bool else {
                    return
                }
                
                others?.append(
                    CommonnPlacesViewModel(
                        name: name,
                        postion: rankingPlace,
                        wentUp: goUpInRanking))
            }
        }
        
        guard let firstPlaceModel,
              let secondPlaceModel,
              let thirdPlaceModel,
              var others else { return nil }
        
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
