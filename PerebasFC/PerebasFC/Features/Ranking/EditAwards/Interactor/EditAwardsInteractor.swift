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
    private let model: EditAwardsViewModel
    
    init(coordinator:EditAwardsCoordinatorProtocol,
         presenter: EditAwardsPresenterProtocol,
         model: EditAwardsViewModel) {
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
        coordinator.setNewAwards(with: model)
    }
    
}
