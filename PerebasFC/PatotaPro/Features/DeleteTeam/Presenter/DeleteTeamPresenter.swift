//
//  DeleteTeamPresenter.swift
//  PatotaPro
//
//  Created by Amanda Detofol on 26/11/23.
//

import Foundation

protocol DeleteTeamPresenterProtocol {
    func updateView()
    func updateViewForIdTextFieldErrorState()
}

protocol DeleteTeamViewProtocol: AnyObject {
    func updateView(with model: DeleteTeamViewModel)
    func updateViewForIdTextFieldErrorState()
}

final class DeleteTeamPresenter: DeleteTeamPresenterProtocol {
    
    weak var view: DeleteTeamViewProtocol?
    
    func updateView() {
        view?.updateView(
            with: DeleteTeamViewModel(
                message: "Digite o ID do time que você deseja excluir. Ao excluir o time, todos os usuários que fazem parte desse time serão desvinculados deste time também. ",
                title: "ID do time",
                buttonTitle: "Confirmar"))
    }
    
    func updateViewForIdTextFieldErrorState(){
        view?.updateViewForIdTextFieldErrorState()
    }
    
}
