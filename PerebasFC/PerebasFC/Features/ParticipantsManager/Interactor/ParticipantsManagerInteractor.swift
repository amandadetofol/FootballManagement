//
//  ParticipantsManagerInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/08/23.
//

import Foundation

final class ParticipantsManagerInteractor: ParticipantsManagerInteractorProtocol {
    
    let worker: ParticipantsManagerWorkerProtocol
    let presenter: ParticipantsManagerPresenterProtocol
    let coordinator: ParticipantsManagerCoordinatorProtocol
    
    init(worker: ParticipantsManagerWorkerProtocol,
         presenter: ParticipantsManagerPresenterProtocol,
         coordinator: ParticipantsManagerCoordinatorProtocol){
        self.worker = worker
        self.presenter = presenter
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        worker.getParticipants { [weak self] users in
            self?.presenter.updateView(with: users)
        }
    }
    
    func handleParticipantCardViewTap(user: User) {
        coordinator.openPersonalInformationsView(user: user)
    }
    
    func updateView(basedOn segmentedControlIndex: Int) {
        
    }

}
