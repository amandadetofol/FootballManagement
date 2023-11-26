//
//  ParticipantsSelectorListViewInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 04/09/23.
//

import Foundation

final class ParticipantsSelectorListViewInteractor: ParticipantsSelectorListViewInteractorProtocol {
    
    private let worker: ParticipantsSelectorListViewWorkerProtocol
    private let coordinator: ParticipantsSelectorListViewCoordinatorProtocol
    private let presenter: ParticipantsSelectorListViewPresenterProtocol
    
    init(worker: ParticipantsSelectorListViewWorkerProtocol,
         coordinator: ParticipantsSelectorListViewCoordinatorProtocol,
         presenter: ParticipantsSelectorListViewPresenterProtocol) {
        self.worker = worker
        self.coordinator = coordinator
        self.presenter = presenter
    }
    
    func viewDidLoad() {
        worker.getParticipants { [weak self] users in
            guard let self,
                  let users else {
                      self?.coordinator.showErrorAlert()
                      return
                  }
            self.presenter.updateView(with: users)
        }
    }
    
    func handleParticipantsSelectorCardViewTap(name: String) {
        coordinator.dissmissToDebitViewWithSelectedUser(name: name)
    }
    
}
