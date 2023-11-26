//
//  HomePresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 25/05/23.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func updateViewForState(isAdm: Bool, model: HomeViewModel)
    func updateViewWith(imageUrl: String, colorname: String)
}

final class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeViewProtocol?
    
    func updateViewWith(imageUrl: String, colorname: String) {
        view?.updateViewWith(imageUrl: imageUrl, colorname: colorname)
    }
    
    func updateViewForState(isAdm: Bool, model: [MenuItemViewModel]) {
        let data = parseFirebaseModelToViewModel(model)
        view?.updateViewForState(
            isAdm: isAdm,
            model: data)
    }
    
    private func parseFirebaseModelToViewModel(_ model: [MenuItemViewModel]) -> HomeViewModel {
        return HomeViewModel(
            isAdm: Session.shared.isAdm ?? false ,
            header: HomeHeaderViewModel(
                welcomeText: "Olá!",
                fullName: "\(Session.shared.loggedUserEmail ?? "")"),
            menuCards: model)
    }
    
}
