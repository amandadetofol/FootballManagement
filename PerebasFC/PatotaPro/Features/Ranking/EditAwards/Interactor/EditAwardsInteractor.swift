//
//  EditAwardsInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 15/06/23.
//

import Foundation

protocol EditAwardsPresenterProtocol {
    func updateView(fwith model: EditAwardsViewModel)
}

final class EditAwardsInteractor: EditAwardsViewInteractorProtocol {
    
    private let coordinator: EditAwardsCoordinatorProtocol
    private let presenter: EditAwardsPresenterProtocol
    private let worker: EditAwardsWorkerProtocol
    private let model: EditAwardsViewModel
    
    init(coordinator:EditAwardsCoordinatorProtocol,
         presenter: EditAwardsPresenterProtocol,
         worker: EditAwardsWorkerProtocol,
         model: EditAwardsViewModel) {
        self.worker = worker
        self.coordinator = coordinator
        self.presenter = presenter
        self.model = model
    }
    
    func viewDidLoad() {
        presenter.updateView(fwith: model)
    }
    
    func handleGoToBackButtonTap() {
        coordinator.goToBack()
    }
    
    func handleSetNewAwardsButtonTap(using model: FirstPlaceGiftsViewModel) {
        coordinator.showLoading { [weak self] in
            guard let self else { return }
            self.worker.updateAwards(newAwards: model) {  succeeded in
                self.coordinator.removeLoading {
                    if succeeded {
                        self.coordinator.showSuccessAlert()
                    } else {
                        self.coordinator.showErrorAlert()
                    }
                }
            }
        }
    }
    
}
