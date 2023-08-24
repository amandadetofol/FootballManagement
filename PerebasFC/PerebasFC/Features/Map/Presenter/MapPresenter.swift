//
//  MapPresente.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 23/08/23.
//

import Foundation

protocol MapPresenterProtocol {
    func updateView(with url: String)
}

protocol MapViewProtocol: AnyObject {
    func updateView(with url: String)
}

final class MapPresenter: MapPresenterProtocol {
    
    weak var view: MapViewProtocol?
    
    func updateView(with url: String){
        view?.updateView(with: url)
    }
}
