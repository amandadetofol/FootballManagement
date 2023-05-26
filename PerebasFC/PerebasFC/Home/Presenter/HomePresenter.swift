//
//  HomePresenter.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 25/05/23.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func updateViewForState(isAdm: Bool, model: HomeViewModel) 
}

final class HomePresenter: HomePresenterProtocol {

    weak var view: HomeViewProtocol?
    
    func updateViewForState(isAdm: Bool, model: User) {
        
    }
    
    private func parseFirebaseModelToViewModel(_ user: User) -> HomeViewModel {
        
        var warningModel: UserAlertWarningViewModel? = nil 
        if let warning = user.warning {
            warningModel = UserAlertWarningViewModel(
                icon: user.warning?.icon ?? UIImage(),
                warning: warning)
        }
        
        return HomeViewModel(
            isAdm: user.isAdm,
            header: HomeHeaderViewModel(
                welcomeText: "Olá!",
                fullName: "\(user.firstName) \(user.lastName)"),
            teamInfo: HomeTeamInfo(
                shirtNumber: user.shirtNumber,
                teamName: user.team,
                position: user.position),
            menuCards: user.menuItems,
            warning: warningModel)
        
    }
    
}
