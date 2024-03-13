//
//  SortMainInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/08/23.
//

import Foundation

final class SortMainInteractor: SortMainViewInteractorProtocol {
    
    var weekTeam: WeekTeamViewModel?
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
    
    func showSwipeAlert(){
        coordinator.showSwipeAlert()
    }
    
    func viewDidLoad() {
        coordinator.showLoading { [weak self] in
            guard let self else { return }
            self.worker.getSorts {  sorts in
                guard let sorts else {
                    self.coordinator.removeLoading {
                        self.coordinator.showErrorPopUp()
                    }
                    return
                }
                self.coordinator.removeLoading {
                    self.presenter.updateView(with: sorts)
                }
            }
        }
        
    }
    
    func handleNewSort() {
        coordinator.showLoading { [weak self] in
            guard let self else { return }
            worker.handleNewSort { whiteTeam, blackTeam in
                
                self.coordinator.removeLoading {
                    guard let whiteTeam,
                          let blackTeam else {
                        self.coordinator.showErrorPopUp()
                        return
                    }
                    
                    self.coordinator.showSuccessPopUp(
                        model: WeekTeamViewModel(
                            whiteTeam: Team(players: whiteTeam),
                            blackTeam: Team(players: blackTeam)))
                }
            }
        }
    }
    
    func goToSortedGameDetailsView(weekTeam: WeekTeamViewModel) {
        coordinator.goToWeekTeamView(model: weekTeam)
    }
    
}
