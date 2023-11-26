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
        coordinator.showLoading()
        worker.getParticipants { [weak self] users in
            guard let self else { return }
            self.coordinator.removeLoading()
            self.presenter.updateView(with: users)
        }
    }
    
    func handleParticipantCardViewTap(email: String) {
        coordinator.openPersonalInformationsView(email: email)
    }
    
    func updateView(basedOn segmentedControlIndex: Int) {
        presenter.updateView(basedOn: segmentedControlIndex)
    }
    
    func setupViewForErrorState(){
        coordinator.showErrorAlert()
    }
    
}
