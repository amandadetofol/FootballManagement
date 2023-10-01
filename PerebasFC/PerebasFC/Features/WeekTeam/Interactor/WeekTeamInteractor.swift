//
//  WeekTeamInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 29/05/23.
//

import Foundation
import FirebaseFirestore

protocol WeekTeamPresenterProtocol {
    func updateTeam(basedOn index: Int, teams: WeekTeamViewModel)
    func updateFirebaseModelToViewModel(
        whiteTeam: QuerySnapshot, blackTeam: QuerySnapshot)
}

final class WeekTeamInteractor: WeekTeamInteractorProtocol {

    private let worker: WeekTeamWithApiCallWorkerProtocol
    private let presenter: WeekTeamPresenterProtocol
    private let coordinator: WeekTeamCoordinatorProtocol
    var teams: WeekTeamViewModel?
    var shouldCallApi: Bool
    
    init(
        coordinator: WeekTeamCoordinatorProtocol,
        worker: WeekTeamWithApiCallWorkerProtocol,
        presenter: WeekTeamPresenterProtocol,
        teams: WeekTeamViewModel?,
        shouldCallApi: Bool){
            self.presenter = presenter
            self.teams = teams
            self.worker = worker
            self.shouldCallApi = shouldCallApi
            self.coordinator = coordinator
    }
    
    func updateTeam(basedOn index: Int) {
        if shouldCallApi {
            coordinator.showLoading()
            worker.getCurrentAvailableSortedTeams(completion: { [weak self] whiteTeam, blackTeam in
                guard let self,
                      let whiteTeam,
                      let blackTeam else {
                    
                    self?.coordinator.removeLoading()
                    self?.coordinator.showErrorView()
                    
                    return
                }
                
                self.coordinator.removeLoading()
                presenter.updateFirebaseModelToViewModel(
                    whiteTeam: whiteTeam,
                    blackTeam: blackTeam)
            })
            
        } else {
            guard let teams else { return }
            presenter.updateTeam(basedOn: index, teams: teams)
        }
    }
    
}
