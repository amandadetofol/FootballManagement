//
//  AccessibilityManagerInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 13/08/23.
//

import Foundation

final class AccessibilityManagerInteractor: AccessibilityManagerInteractorProtocol {
    
    private let presenter: AccessibilityManagerPresenterProtocol
    private let coordinator: AccessibilityManagerCoordinatorProtocol
    private let model: [AccessibilityManagerViewModel]
    
    init(presenter: AccessibilityManagerPresenterProtocol,
         coordinator: AccessibilityManagerCoordinatorProtocol,
         model: [AccessibilityManagerViewModel]){
        self.presenter = presenter
        self.coordinator = coordinator
        self.model = model
    }
    
    func viewDidLoad() {
        presenter.updatView(with: model)
    }
    
    func didTapButton(){
        coordinator.handleButtonTap()
    }

}
