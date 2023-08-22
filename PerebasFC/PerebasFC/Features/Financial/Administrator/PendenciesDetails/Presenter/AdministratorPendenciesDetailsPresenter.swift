//
//  AdministratorPendenciesDetailsPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 19/08/23.
//

import Foundation

protocol AdministratorPendenciesDetailsPresenterProtocol {
    func updateView(with model: FinancialAdministratorPendenciesListCardModel)
}

protocol AdministratorPendenciesDetailsViewProtocol: AnyObject {
    func updateView(with model: FinancialAdministratorPendenciesListCardModel)
}

final class AdministratorPendenciesDetailsPresenter: AdministratorPendenciesDetailsPresenterProtocol {
    
    weak var view: AdministratorPendenciesDetailsViewProtocol?
    
    func updateView(with model: FinancialAdministratorPendenciesListCardModel) {
        view?.updateView(with: model)
    }
    
}
