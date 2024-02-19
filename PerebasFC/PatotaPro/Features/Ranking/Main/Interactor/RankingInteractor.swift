//
//  RankingInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import Foundation
import FirebaseFirestore

protocol RankingPresenterProtocol {
    func updateView(with model: QuerySnapshot)
    func updatePricesWith(with model: DocumentSnapshot?)
}

final class RankingInteractor: RankingInteractorProtocol {
    
    private let presenter: RankingPresenterProtocol
    private let worker: RankingWorkerProtocol
    private let coordinator: RankingCoordinator
    
    init(presenter: RankingPresenterProtocol,
         worker: RankingWorkerProtocol,
         coordinator: RankingCoordinator) {
        self.presenter = presenter
        self.worker = worker
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        coordinator.showLoading { [weak self] in
            guard let self else { return }
            
            worker.getPrices { documentSnapShot in 
                self.presenter.updatePricesWith(with: documentSnapShot)
            }
            
            worker.getRanking { data in
                guard let data = data else {
                    self.coordinator.dissmissLoading {
                        self.coordinator.showAlertErrorPopUp()
                    }
                    return
                }
                self.coordinator.dissmissLoading {
                    if data.documents.count < 3 {
                        DispatchQueue.main.async {
                            self.coordinator.showUnsufficentPlayersMessage()
                        }
                    } else {
                        self.presenter.updateView(with: data)
                    }
                }
            }
        }
    }
    
    func showUnsufficentPlayersMessage() {
        coordinator.showUnsufficentPlayersMessage()
    }
    
    func handleEditAwardsButtonTap(with model: EditAwardsViewModel) {
        coordinator.goToShowEditAwardsView(model: model)
    }
    
}
