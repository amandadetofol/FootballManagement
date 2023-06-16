//
//  EditAwardsInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 15/06/23.
//

import Foundation

final class EditAwardsInteractor: EditAwardsViewInteractorProtocol {
    
    private let coordinator: EditAwardsCoordinatorProtocol
    private let model: EditAwardsViewModel
    
    init(coordinator:EditAwardsCoordinatorProtocol,
         model: EditAwardsViewModel) {
        self.coordinator = coordinator
        self.model = model
    }
    
    func viewDidLoad() {
        
    }
    
    func handleGoToBackButtonTap() {
        
    }
    
    func handleSetNewAwardsButtonTap(using model: FirstPlaceGiftsViewModel) {
        
    }
    
}
