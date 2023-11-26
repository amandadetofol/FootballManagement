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
        coordinator.showLoading()
        worker.getPrices { [weak self] documentSnapShot in
            guard let self else { return }
            self.presenter.updatePricesWith(with: documentSnapShot)
        }
        
        worker.getRanking { [weak self] data in
            guard let self else { return }
            guard let data = data else {
                self.coordinator.dissmissLoading()
                self.coordinator.showAlertErrorPopUp()
                return
            }
            self.coordinator.dissmissLoading()
            self.presenter.updateView(with: data)
        }
    }
    
    func showUnsufficentPlayersMessage() {
        coordinator.showUnsufficentPlayersMessage()
    }
    
    func handleEditAwardsButtonTap(with model: EditAwardsViewModel) {
        coordinator.goToShowEditAwardsView(model: model)
    }
    
}
