//
//  NewTeamSignUpInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 04/11/23.
//

import Foundation

final class NewTeamSignUpInteractor: NewTeamSignUpInteractorProtocol {
    
    private let model: NewTeamSignUpViewModel
    private let presenter: NewTeamSignUpPresenterProtocol
    private let coordinator: NewTeamSignUpCoordinatorProtocol
    private let worker: NewTeamSignUpWorkerProtocol
    
    init(model: NewTeamSignUpViewModel = NewTeamSignUpViewModel(),
         presenter: NewTeamSignUpPresenterProtocol,
         coordinator: NewTeamSignUpCoordinatorProtocol,
         worker: NewTeamSignUpWorkerProtocol){
        self.model = model
        self.presenter = presenter
        self.coordinator = coordinator
        self.worker = worker
    }
    
    func viewDidLoad() {
        presenter.updateView(with: model)
    }
    
    func handleCreateNewFootballTeam(model: NewTeamSignUpModel) {
        var hasError = false
        
        if model.name.isEmpty {
            presenter.updateViewForfootballTeamTextFieldHasError()
            hasError = true
        }
        
        if model.minPoinTeam.isEmpty {
            presenter.updateViewForSumPointsTeamTextFieldHasError()
            hasError = true
        }
        
        if model.sumPointTeam.isEmpty {
            presenter.updateViewMinPointsTeamTextFieldHasError()
            hasError = true
        }
       
        if model.sumPointGoal.isEmpty {
            presenter.updateViewSumUserPointsTeamTextFieldHasError()
            hasError = true
        }
       
        if Float(model.minPoinTeam) == nil {
            presenter.updateViewSumPointsTeamTextFieldNotFloarError()
            hasError = true
        }
        
        if Float(model.sumPointTeam) == nil {
            presenter.updateViewMinPointsTeamTextFielNotFloatdHasError()
            hasError = true
        }
    
        if Float(model.sumPointGoal) == nil {
            presenter.updateViewSumUserPointsTeamTextFieldNotFloatHasError()
            hasError = true 
        }
        
        if hasError { return }
        
        worker.createNewGameOnFirebase(model: model) { [weak self] id in
            guard let self else { return }
            self.coordinator.removeLoading()
            
            if let id {
                coordinator.showIdAlertView(id: id)
            } else {
                coordinator.showErrorAlertView()
            }
            
        }
    }
    
    func showColorContrastProblemAlert(){
        coordinator.showColorContrastProblemAlert()
    }
    
}
