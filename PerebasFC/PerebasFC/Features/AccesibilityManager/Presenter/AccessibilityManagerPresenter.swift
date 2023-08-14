//
//  AccessibilityManagerPresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 13/08/23.
//

import Foundation

protocol AccessibilityManagerPresenterProtocol {
    func updatView(with model: [AccessibilityManagerViewModel])
}

protocol AccessibilityManagerViewProtocol: AnyObject {
    func updatView(with model: [AccessibilityManagerViewModel])
}

final class AccessibilityManagerPresenter: AccessibilityManagerPresenterProtocol {
   
    weak var view: AccessibilityManagerViewProtocol?
    
    func updatView(with model: [AccessibilityManagerViewModel]) {
        view?.updatView(with: model)
    }
    
}
