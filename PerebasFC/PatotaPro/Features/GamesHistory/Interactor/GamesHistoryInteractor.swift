//
//  GamesHistoryInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 30/05/23.
//

import Foundation
import FirebaseFirestore

protocol GamesHistoryPresenterProtocol {
    func updateView(using model: QuerySnapshot)
}

final class GamesHistoryInteractor: GamesHistoryInteractorProtocol {

    private let presenter: GamesHistoryPresenterProtocol
    private let worker: GamesHistoryWorkerProtocol
    private let coordinator: GamesHistoryCoordinatorProtocol
    
    init(presenter: GamesHistoryPresenterProtocol,
         worker: GamesHistoryWorkerProtocol,
         coordinator: GamesHistoryCoordinatorProtocol) {
        self.presenter = presenter
        self.worker = worker
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        worker.getGamesHistory { [weak self] game in
            guard let game = game else {
                self?.coordinator.showAlertErrorView()
                return
            }
            
            if game.count == 0 {
                self?.coordinator.showEmptyAlert()
            } else {
                self?.presenter.updateView(using: game)
            }
            
        }
    }
    
    func handleEditGameButtonTap(game: Game) {
        coordinator.goToEditGameView(game: game)
    }
    
    func handleNewGameButtonTap(){
        coordinator.goToAddNewGame()
    }
    
    func saveNewGame(game: Game){
        coordinator.showLoading()
        worker.addNewGame(
            game: game) { [weak self] succeded in
                guard let self else { return }
                self.coordinator.removeLoading()
                
                if succeded {
                    self.coordinator.showSuccessAddGameAlert()
                } else {
                    self.coordinator.showAlertErrorView()
                }
            }
    }

}
