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
    func goToBack(
        hasChangeUrl: Bool,
        newUrl: String)
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
        coordinator.showLoading()
        worker.getLocal { [weak self] documentSnapShot in
            guard let self else { return }
            self.coordinator.removeLoading()
            self.presenter.updateView(with: documentSnapShot)
        }
    }
    
    func handleShareButtonTap() {
        guard let url = self.url else { return }
        coordinator.shareLocalUrl(url: url)
    }
    
    func goToBack(
        hasChangeUrl: Bool,
        newUrl: String) {
            if hasChangeUrl {
                coordinator.showConfirmLocaleChangeAlert { [weak self] in
                    guard let self else { return }
                    self.coordinator.showLoading()
                    self.worker.updateGameLocal(
                        gameLocalNewUrl: newUrl) { succeded in
                            self.coordinator.removeLoading()
                            if !succeded {
                                self.coordinator.showErrorPopUp()
                            }
                        }
                    
                }
            } else {
                self.coordinator.goToBack()
            }
        }
 
}
