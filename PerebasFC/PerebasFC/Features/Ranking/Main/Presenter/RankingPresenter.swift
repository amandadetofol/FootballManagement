//
//  RankingPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import Foundation

protocol RankingViewProtocol: AnyObject {
    func updateView(with model: RankingViewModel)
}

final class RankingPresenter: RankingPresenterProtocol {
    
    weak var view: RankingViewProtocol?
    
    func updateView(with model: RankingViewModel) {
        view?.updateView(with: model)
    }
    
}
