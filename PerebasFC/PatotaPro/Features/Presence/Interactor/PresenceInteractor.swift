//
//  PresenceInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/09/23.
//

import UIKit

final class PresenceInteractor: PresenceInteractorProtocol {
    
    private let presenter: PresencePresenterProtocol
    private let worker: PresenceWorkerProtocol
    private let coordinator: PresenceCoordinatorProtocol
    private let gameId: String
    
    init(presenter: PresencePresenterProtocol,
         worker: PresenceWorkerProtocol,
         coordinator: PresenceCoordinatorProtocol,
         gameId: String ) {
        self.presenter = presenter
        self.coordinator = coordinator
        self.worker = worker
        self.gameId = gameId
    }

    func viewDidLoad() {
        coordinator.showLoading()
        worker.getUsers(id: gameId) { [weak self] model, hasComeFromGamesDb  in
            guard let self,
                  let model = model else {
                      self?.coordinator.removeLoading()
                      self?.coordinator.showErrorAlert()
                      
                      return
                  }
            self.coordinator.removeLoading()
            self.presenter.updateView(with: model, hasComeFromGamesDatabase: hasComeFromGamesDb)
        }
    }
    
    func handleConfirmButtonTap(model: [PresenceCardViewModel]) {
        worker.savePresence(
            presence: model,
            completion: { [weak self] succeded in
                if succeded {
                    self?.coordinator.handleOkButtonTap()
                } else {
                    self?.coordinator.showLoading()
                }
            },
            id: gameId)
    }

}
