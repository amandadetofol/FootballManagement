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
    private let model: Game
    private let isNewGame: Bool
    
    init(presenter: EditGamePresenterProtocol,
         coordinator: EditGameCoordinatorProtocol,
         model: Game,
         isNewGame: Bool){
        self.presenter = presenter
        self.coordinator = coordinator
        self.model = model
        self.isNewGame = isNewGame
    }
    
    func viewDidLoad() {
        presenter.updateView(with: self.model)
        presenter.addListOfPresenceButton()
    }

    func handleSaveNewGameInformationsButtonTap(game: Game) {
        if isNewGame {
            coordinator.handleSaveNewGame(game: game)
        }
        coordinator.handleSaveNewGameInformationsButtonTap(game: game)
    }
    
    func handleAddListOfPresenceButtonTap(){
        coordinator.handleAddListOfPresenceButtonTap()
    }
    
}
