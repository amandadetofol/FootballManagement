//
//  SortMainInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/08/23.
//

import Foundation

final class SortMainInteractor: SortMainViewInteractorProtocol {
    
    private let worker: SortMainWorkerProtocol
    private let coordinator: SortMainCoordinatorProtocol
    
    init(worker: SortMainWorkerProtocol,
         coordinator: SortMainCoordinatorProtocol) {
        self.worker = worker
        self.coordinator = coordinator
    }
    
    func handleNewSort() {
        
    }
    
    func goToSortedGameDetailsView(weekTeam: WeekTeamViewModel) {
        coordinator.goToWeekTeamView(model: weekTeam)
    }

}
