//
//  NewTeamSignUpViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 04/11/23.
//

import UIKit

protocol NewTeamSignUpInteractorProtocol: AnyObject {
    func viewDidLoad()
    func showColorContrastProblemAlert()
    func handleCreateNewFootballTeam(model: NewTeamSignUpModel)
}

final class NewTeamSignUpViewController: UIViewController {
    
    private lazy var newTeamSignUpView: NewTeamSignUpView = {
        let newTeamSignUpView = NewTeamSignUpView(controller: self)
        newTeamSignUpView.delegate = self
        
        return newTeamSignUpView
    }()
    
    private let interactor: NewTeamSignUpInteractorProtocol
    
    init(interactor: NewTeamSignUpInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Nova patota"
        
        view.backgroundColor = .white
        
        self.view = newTeamSignUpView
        interactor.viewDidLoad()
    }
    
}

extension NewTeamSignUpViewController: NewTeamSignUpViewDelegate {
   
    func handleCreateNewFootballTeam(model: NewTeamSignUpModel) {
        interactor.handleCreateNewFootballTeam(model: model)
    }
    
    func showColorContrastProblemAlert(){
        interactor.showColorContrastProblemAlert()
    }
    
}

extension NewTeamSignUpViewController: NewTeamSignUpViewProtocol {
    
    func updateViewForfootballTeamTextFieldHasError() {
        newTeamSignUpView.footballTeamTextFieldHasError = true
    }
    
    func updateViewForSumPointsTeamTextFieldHasError() {
        newTeamSignUpView.sumPointsTeamTextFieldHasError = true
    }
    
    func updateViewMinPointsTeamTextFieldHasError() {
        newTeamSignUpView.minPointsTeamTextFieldHasError = true
    }
    
    func updateViewSumUserPointsTeamTextFieldHasError() {
        newTeamSignUpView.sumUserPointsTeamTextFieldHasError = true
    }
    
    func updateViewSumPointsTeamTextFieldNotFloarError() {
        newTeamSignUpView.sumPointsTeamTextFieldNotFloarError = true
    }
    
    func updateViewMinPointsTeamTextFielNotFloatdHasError() {
        newTeamSignUpView.minPointsTeamTextFielNotFloatdHasError = true
    }
    
    func updateViewSumUserPointsTeamTextFieldNotFloatHasError() {
        newTeamSignUpView.sumUserPointsTeamTextFieldNotFloatHasError = true 
    }
    
    func updateView(with model: NewTeamSignUpViewModel) {
        newTeamSignUpView.updateView(newTeamSignUpViewModel: model)
    }
    
}
