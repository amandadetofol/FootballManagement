//
//  FinancialAdministratorMainPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 14/08/23.
//

import Foundation

protocol FinancialAdministratorMainPresenterProtocol {
    func updateView(with model: FinancialAdministratorMainViewModel)
}

protocol FinancialAdministratorMainViewProtocol: AnyObject {
    func updateView(with model: FinancialAdministratorMainViewModel)
}

final class FinancialAdministratorMainPresenter: FinancialAdministratorMainPresenterProtocol {
    
    weak var view: FinancialAdministratorMainViewProtocol?
    
    func updateView(with model: FinancialAdministratorMainViewModel) {
        view?.updateView(with: model)
    }

}
