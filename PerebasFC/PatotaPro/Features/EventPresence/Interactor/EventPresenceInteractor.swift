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
    private let itemId: String
    
    init(coordinator: EventPresenceCoordinatorProtocol,
         presenter: EventPresencePresenterProtocol,
         worker: EventPresenceWorkerProtocol,
         itemId: String){
        self.coordinator = coordinator
        self.presenter = presenter
        self.worker = worker
        self.itemId = itemId
    }
    
    func viewDidLoad() {
        
        coordinator.showLoading()
        worker.getEventPresenceModel(itemId: itemId) { [weak self] querysnapshot in
            guard let self,
                  let querysnapshot else {
                self?.coordinator.removeLoading()
                self?.coordinator.showErrorAlert()
                return 
            }
            
            self.coordinator.removeLoading()
            self.presenter.updateView(with: querysnapshot)
        }
    }

}
