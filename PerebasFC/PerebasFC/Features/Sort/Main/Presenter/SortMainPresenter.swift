//
//  SortMainPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/08/23.
//

import Foundation

protocol SortMainPresenterProtocol {
    func updateView(with model: SortGameMainViewModel)
}

protocol SortMainViewProtocol: AnyObject {
    func updateView(with model: SortGameMainViewModel)
}

final class SortMainPresenter: SortMainPresenterProtocol {
    
    var view: SortMainViewProtocol?
    
    func updateView(with model: SortGameMainViewModel){
        view?.updateView(with: model)
    }
    
}
