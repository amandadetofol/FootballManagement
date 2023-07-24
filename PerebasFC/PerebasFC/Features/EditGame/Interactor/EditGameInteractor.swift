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
    
    init(presenter: EditGamePresenterProtocol,
         coordinator: EditGameCoordinatorProtocol,
         model: Game){
        self.presenter = presenter
        self.coordinator = coordinator
        self.model = model
    }
    
    func viewDidLoad() {
        presenter.updateView(with: self.model)
    }

    func handleSaveNewGameInformationsButtonTap(game: Game) {
        coordinator.handleSaveNewGameInformationsButtonTap(game: game)
    }
    
}
