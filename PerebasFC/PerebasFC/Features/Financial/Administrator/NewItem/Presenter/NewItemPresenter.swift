//
//  NewItemPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 23/09/23.
//

import Foundation

protocol NewItemPresenterProtocol {
    func updateViewForDescriptionFieldErrorState()
    func updateViewForValueFieldErrorState()
}

protocol NewItemViewProtocol: AnyObject {
    func updateViewForDescriptionFieldErrorState()
    func updateViewForValueFieldErrorState()
}

final class NewItemPresenter: NewItemPresenterProtocol {
    
    weak var view: NewItemViewProtocol?
    
    func updateViewForDescriptionFieldErrorState() {
        view?.updateViewForDescriptionFieldErrorState()
    }
    
    func updateViewForValueFieldErrorState() {
        view?.updateViewForValueFieldErrorState()
    }
    
}
