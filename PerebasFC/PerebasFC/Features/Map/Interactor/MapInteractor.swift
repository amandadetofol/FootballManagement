//
//  MapInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 23/08/23.
//

import Foundation

protocol MapInteractorProtocol {
    
    var url: String? { get set }
    
    func loadView()
    func goToBack(hasChangeUrl: Bool)
    func handleShareButtonTap()
}

final class MapInteractor: MapInteractorProtocol {
    
    var url: String?
    private let worker: MapWorkerProtocol
    private let presenter: MapPresenterProtocol
    private let coordinator: MapCoordinatorProtocol
    
    init(worker: MapWorkerProtocol,
         presenter: MapPresenterProtocol,
         coordinator: MapCoordinatorProtocol) {
        self.worker = worker
        self.presenter = presenter
        self.coordinator = coordinator
    }
    
    func loadView() {
        presenter.updateView(
            with: worker.getLocalUrl())
        self.url = worker.getLocalUrl()
    }
    
    func handleShareButtonTap() {
        guard let url = self.url else { return }
        coordinator.shareLocalUrl(url: url)
    }
    
    func goToBack(hasChangeUrl: Bool) {
        if hasChangeUrl {
            coordinator.showConfirmLocaleChangeAlert()
        } else {
            self.coordinator.goToBack()
        }
    }
 
}
