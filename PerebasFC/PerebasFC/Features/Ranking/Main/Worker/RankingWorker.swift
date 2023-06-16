//
//  RankingWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import Foundation

protocol RankingWorkerProtocol {
    func getRanking(_ completion: @escaping ((RankingViewModel?) -> Void))
}

final class RankingWorker: RankingWorkerProtocol {
    
    func getRanking(_ completion: @escaping ((RankingViewModel?) -> Void)) {
       
        let rankingViewModelMock = RankingViewModel(
            firstPlaceModel: BarAndTrophyViewModel(
                initials: "JL",
                postiionLabel: 1,
                barColor: .gold,
                trophyColor: .gold
            ),
            secondPlaceModel: BarAndTrophyViewModel(
                initials: "KT",
                postiionLabel: 2,
                barColor: .gold,
                trophyColor: .silver
            ),
            thirdPlaceModel: BarAndTrophyViewModel(
                initials: "MS",
                postiionLabel: 3,
                barColor: .gold,
                trophyColor: .browned
            ),
            awards: FirstPlaceGiftsViewModel(
                first: "1 - Premio 01",
                second: "2 - Premio 02",
                third: "3 - Premio 03",
                isAdm: Session.shared.isAdm ?? false 
            ),
            otherParticipants: [
                CommonnPlacesViewModel(
                    name: "Nome sobrenome",
                    postion: 4,
                    wentUp: false
                ),
                CommonnPlacesViewModel(
                    name: "Nome sobrenome",
                    postion: 5,
                    wentUp: true
                ),
                CommonnPlacesViewModel(
                    name: "Nome sobrenome",
                    postion: 6,
                    wentUp: false
                )
            ]
        )
        
        completion(rankingViewModelMock)
    }
    
}
