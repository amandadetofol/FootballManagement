//
//  EditGameInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/06/23.
//

import Foundation

final class EditGameInteractor: EditGameInteractorProtocol {
    
    private let coordinator: EditGameCoordinatorProtocol
    private let presenter: EditGamePresenterProtocol
    private let worker: GamesHistoryWorkerProtocol
    private let model: Game
    private let isNewGame: Bool
    
    init(presenter: EditGamePresenterProtocol,
         coordinator: EditGameCoordinatorProtocol,
         worker: GamesHistoryWorkerProtocol,
         model: Game,
         isNewGame: Bool){
        self.presenter = presenter
        self.coordinator = coordinator
        self.model = model
        self.isNewGame = isNewGame
        self.worker = worker
    }
    
    func viewDidLoad() {
        coordinator.showLoading { [weak self] in
            guard let self else { return }
            
            self.worker.getParticipants { querySnapshot in
                guard let querySnapshot else {
                    self.coordinator.removeLoading {
                        self.coordinator.showErrorAlert()
                    }
                    return
                }
                
                self.coordinator.removeLoading {
                    self.presenter.updateView(
                        with: self.model,
                        players: querySnapshot)
                }
            }
          
            self.presenter.addListOfPresenceButton()
        }
    }

    func handleSaveNewGameInformationsButtonTap(game: Game) {
        coordinator.handleSaveNewGame(game: game)
    }
    
    func handleAddListOfPresenceButtonTap(){
        coordinator.handleAddListOfPresenceButtonTap(game: model)
    }
    
}
