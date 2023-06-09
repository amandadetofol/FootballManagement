//
//  ChatMainPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 09/06/23.
//

import Foundation

protocol ChatMainViewProtocol: AnyObject {
    func updateView(with model: [ChatItemViewModel])
}

final class ChatMainPresenter: ChatMainPresenterProtocol {
    
    weak var view: ChatMainViewProtocol?
   
    func updateView(with model: [ChatItemViewModel]) {
        view?.updateView(with: model)
    }

}
