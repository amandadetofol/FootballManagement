//
//  SortMainInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/08/23.
//

import Foundation

final class SortMainInteractor: SortMainViewInteractorProtocol {
    
    private let presenter: SortMainPresenter
    private let worker: SortMainWorkerProtocol
    private let coordinator: SortMainCoordinatorProtocol
    
    init(worker: SortMainWorkerProtocol,
         presenter: SortMainPresenter,
         coordinator: SortMainCoordinatorProtocol) {
        self.worker = worker
        self.coordinator = coordinator
        self.presenter = presenter
    }
    
    func viewDidLoad() {
        worker.getSorts { [weak self] sorts in
            guard let self = self else { return }
            presenter.updateView(with: sorts)
        }
    }
    
    func handleNewSort() {
        worker.handleNewSort { [weak self] suceded in
            guard let self = self else { return }
            if suceded {
                self.coordinator.showSuccessPopUp()
            } else {
                self.coordinator.showErrorPopUp()
            }
        }
    }
    
    func goToSortedGameDetailsView(weekTeam: WeekTeamViewModel) {
        coordinator.goToWeekTeamView(model: weekTeam)
    }

}
