//
//  EditAwardsPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 18/06/23.
//

import Foundation

protocol EditAwardsViewProtocol: AnyObject {
    func updateView(with model: EditAwardsViewModel)
}

final class EditAwardsPresenter: EditAwardsPresenterProtocol {
    
    weak var view: EditAwardsViewProtocol?
    
    func updateView(fwith model: EditAwardsViewModel) {
        view?.updateView(with: model)
    }
    
}
