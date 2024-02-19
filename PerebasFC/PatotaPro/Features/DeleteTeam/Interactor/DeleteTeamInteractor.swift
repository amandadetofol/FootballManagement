//
//  DeleteTeamInteractor.swift
//  PatotaPro
//
//  Created by Amanda Detofol on 26/11/23.
//

import Foundation

final class DeleteTeamInteractor: DeleteTeamInteractorProtocol {
    
    private let worker: DeleteTeamWorkerProtocol
    private let presenter: DeleteTeamPresenterProtocol
    private let coordinator: DeleteTeamCoordinatorProtocol
    
    init( worker: DeleteTeamWorkerProtocol,
          presenter: DeleteTeamPresenterProtocol,
          coordinator: DeleteTeamCoordinatorProtocol) {
        self.worker = worker
        self.presenter = presenter
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        presenter.updateView()
    }
    
    func handleConfirmButtonTap(id: String) {
        var hasError = false
        
        if id.isEmpty {
            presenter.updateViewForIdTextFieldErrorState()
            hasError = true
        }
        
        if hasError { return }
        
        coordinator.showLoading { [weak self] in
            guard let self else { return }
            self.worker.deleteTeam(
                id: id) {  succeded in
                    self.coordinator.removerLoading{
                        if succeded {
                            self.coordinator.showSuccessMessage()
                        } else {
                            self.coordinator.showErrorMessage()
                        }
                    }
                    
                }
        }
        
    }
    
}
