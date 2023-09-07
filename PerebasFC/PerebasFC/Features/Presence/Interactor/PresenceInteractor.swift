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
    
    init(presenter: PresencePresenterProtocol,
         worker: PresenceWorkerProtocol,
         coordinator: PresenceCoordinatorProtocol) {
        self.presenter = presenter
        self.coordinator = coordinator
        self.worker = worker
    }

    func viewDidLoad() {
        worker.getUsers { [weak self] model in
            self?.presenter.updateView(with: model)
        }
    }
    
    func handleConfirmButtonTap() {
        coordinator.handleOkButtonTap()
    }

}
