//
//  PresencePresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/09/23.
//

import Foundation

protocol PresencePresenterProtocol {
    func updateView(with model: [PresenceCardViewModel])
}

protocol PresenceViewProtocol: AnyObject {
    func updateView(with model: [PresenceCardViewModel])
}

final class PresencePresenter: PresencePresenterProtocol {
    
    weak var view: PresenceViewProtocol?
    
    func updateView(with model: [PresenceCardViewModel]){
        view?.updateView(with: model)
    }
    
}
