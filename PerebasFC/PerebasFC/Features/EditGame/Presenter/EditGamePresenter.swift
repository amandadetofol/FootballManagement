//
//  EditGamePresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/06/23.
//

import Foundation

protocol EditGamePresenterProtocol: AnyObject {
    func addListOfPresenceButton()
    func updateView(with game: Game)
}

protocol EditGameViewProtocol: AnyObject {
    func updateView(with game: Game)
    func addListOfPresenceButton()
}

final class EditGamePresenter: EditGamePresenterProtocol {
    
    weak var view: EditGameViewProtocol?
    
    func updateView(with game: Game) {
        view?.updateView(with: game)
    }
    
    func addListOfPresenceButton(){
        view?.addListOfPresenceButton()
    }
    
}
