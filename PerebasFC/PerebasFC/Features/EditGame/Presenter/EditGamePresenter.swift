//
//  EditGamePresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/06/23.
//

import Foundation

protocol EditGamePresenterProtocol: AnyObject {
    func updateView(with game: Game)
}

protocol EditGameViewProtocol: AnyObject {
    func updateView(with game: Game)
}

final class EditGamePresenter: EditGamePresenterProtocol {
    
    weak var view: EditGameViewProtocol?
    
    func updateView(with game: Game) {
        view?.updateView(with: game)
    }
    
}
