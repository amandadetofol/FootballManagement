//
//  RankingInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import Foundation

protocol RankingPresenterProtocol {
    func updateView(with model: RankingViewModel)
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
        worker.getRanking { [weak self] data in
            guard let data = data else {
                self?.coordinator.showAlertErrorPopUp()
                return
            }
            self?.presenter.updateView(with: data)
        }
    }
    
    func handleEditAwardsButtonTap(with model: EditAwardsViewModel) {
        coordinator.goToShowEditAwardsView(model: model)
    }
    
}
