//
//  NewTeamSignUpPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 04/11/23.
//

import Foundation

protocol NewTeamSignUpPresenterProtocol {
    func updateView(with model: NewTeamSignUpViewModel)
    func updateViewForfootballTeamTextFieldHasError()
    func updateViewForSumPointsTeamTextFieldHasError()
    func updateViewMinPointsTeamTextFieldHasError()
    func updateViewSumUserPointsTeamTextFieldHasError()
    func updateViewSumPointsTeamTextFieldNotFloarError()
    func updateViewMinPointsTeamTextFielNotFloatdHasError()
    func updateViewSumUserPointsTeamTextFieldNotFloatHasError()
}

protocol NewTeamSignUpViewProtocol: AnyObject {
    func updateView(with model: NewTeamSignUpViewModel)
    func updateViewForfootballTeamTextFieldHasError()
    func updateViewForSumPointsTeamTextFieldHasError()
    func updateViewMinPointsTeamTextFieldHasError()
    func updateViewSumUserPointsTeamTextFieldHasError()
    func updateViewSumPointsTeamTextFieldNotFloarError()
    func updateViewMinPointsTeamTextFielNotFloatdHasError()
    func updateViewSumUserPointsTeamTextFieldNotFloatHasError()
}

final class NewTeamSignUpPresenter: NewTeamSignUpPresenterProtocol {
    
    weak var view: NewTeamSignUpViewProtocol?
    
    func updateView(with model: NewTeamSignUpViewModel){
        view?.updateView(with: model)
    }
    
    func updateViewForfootballTeamTextFieldHasError(){
        view?.updateViewForfootballTeamTextFieldHasError()
    }
    
    func updateViewForSumPointsTeamTextFieldHasError(){
        view?.updateViewForSumPointsTeamTextFieldHasError()
    }
    
    func updateViewMinPointsTeamTextFieldHasError(){
        view?.updateViewMinPointsTeamTextFieldHasError()
    }
    
    func updateViewSumUserPointsTeamTextFieldHasError(){
        view?.updateViewSumUserPointsTeamTextFieldHasError()
    }
    
    func updateViewSumPointsTeamTextFieldNotFloarError(){
        view?.updateViewSumPointsTeamTextFieldNotFloarError()
    }
    
    func updateViewMinPointsTeamTextFielNotFloatdHasError(){
        view?.updateViewMinPointsTeamTextFielNotFloatdHasError()
    }
    
    func updateViewSumUserPointsTeamTextFieldNotFloatHasError(){
        view?.updateViewSumUserPointsTeamTextFieldNotFloatHasError()
    }
    
}
