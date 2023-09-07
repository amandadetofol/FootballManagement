//
//  GamesHistoryPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 30/05/23.
//

import Foundation

protocol GamesHistoryViewProtocol: AnyObject {
    func updateView(using model: [Game])
}

final class GamesHistoryPresenter: GamesHistoryPresenterProtocol {

    weak var view: GamesHistoryViewProtocol?
    
    func updateView(using model: [Game]) {
        view?.updateView(using: model)
    }
    
}
