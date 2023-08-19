//
//  AdministratorPendenciesPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 19/08/23.
//

import Foundation

protocol FinancialAdministratorPresenterProtocol {
    func updateView(with model: AdministratorPendenciesViewModel)
    func updateView(basedOn segmentedControlIndex: Int)
}

protocol FinancialAdministratorViewProtocol: AnyObject {
    func updateView(with model: AdministratorPendenciesViewModel)
    func updateView(basedOn segmentedControlIndex: Int)
}

final class AdministratorPendenciesPresenter: FinancialAdministratorPresenterProtocol {
    
    weak var view: FinancialAdministratorViewProtocol?
    
    
    func updateView(with model: AdministratorPendenciesViewModel){
        view?.updateView(with: model)
    }
    
    func updateView(basedOn segmentedControlIndex: Int){
        view?.updateView(basedOn: segmentedControlIndex)
    }
    
}
