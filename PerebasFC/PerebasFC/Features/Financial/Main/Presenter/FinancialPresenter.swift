//
//  FinancialPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 12/06/23.
//

import Foundation

protocol FinancialViewProtocol: AnyObject {
    func updateViewForPayed()
    func updateViewForPendencie()
    func updateView(with model: [FinancialPendencieCardViewModel])
}

final class FinancialPresenter: FinancialPendenciesPresenterProtocol {
    
    weak var view: FinancialViewProtocol?
    
    func updateView(basedOn selectIndex: Int) {
        switch selectIndex {
            case 1:
                view?.updateViewForPayed()
            case 0:
                view?.updateViewForPendencie()
            default:
                return
        }
    }
    
    func updateView(with model: [FinancialPendencieCardViewModel]) {
        view?.updateView(with: model)
    }
    
}
