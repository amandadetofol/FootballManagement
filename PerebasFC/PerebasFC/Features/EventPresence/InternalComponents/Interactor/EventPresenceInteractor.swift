//
//  EventPresenceInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/09/23.
//

import Foundation

final class EventPresenceInteractor: EventPresenceInteractorProtocol {
    
    private let coordinator: EventPresenceCoordinatorProtocol
    private let presenter: EventPresencePresenterProtocol
    private let worker: EventPresenceWorkerProtocol
    
    init(coordinator: EventPresenceCoordinatorProtocol,
         presenter: EventPresencePresenterProtocol,
         worker: EventPresenceWorkerProtocol){
        self.coordinator = coordinator
        self.presenter = presenter
        self.worker = worker
    }
    
    func viewDidLoad() {
        worker.getEventPresenceModel { [weak self] model in
            self?.presenter.updateView(with: model)
        }
    }
    
    func handleConfirmButtonTap() {
        coordinator.handleConfirmButtonTap()
    }
    
}
