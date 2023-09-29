//
//  SortMainPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/08/23.
//

import Foundation
import FirebaseFirestore

protocol SortMainPresenterProtocol {
    func updateView(with model: QuerySnapshot)
}

protocol SortMainViewProtocol: AnyObject {
    func updateView(with model: SortGameMainViewModel)
}

final class SortMainPresenter: SortMainPresenterProtocol {
    
    var view: SortMainViewProtocol?
    
    func updateView(with model: QuerySnapshot){
       // view?.updateView(with: getSortGameMainViewModel(model: model))
        
        getSortGameMainViewModel(model: model)
    }
    
    //MARK: Private func
    private func getSortGameMainViewModel(model: QuerySnapshot)  {
      
    }
    
}
