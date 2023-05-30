//
//  LoginWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 16/05/23.
//

import UIKit

protocol LoginWorkerProtocol {
    func login(
        username: String,
        password: String,
        isAdm: Bool,
        _ completion: @escaping ((User?) -> Void))
}

final class LoginWorker: LoginWorkerProtocol {
    
    func login(
        username: String,
        password: String,
        isAdm: Bool,
        _ completion: @escaping ((User?) -> Void)) {
           
            
                let user = User(
                    firstName: "José",
                    lastName: "Maria",
                    shirtNumber: "08",
                    position: "Zagueiro",
                    team: "Preto",
                    warning: UserWarning(
                        title: "Se lembra desse evento?",
                        description: "Ei, voce vai comparecer no churrasco de amanhã? Não esqueça de confirmar sua presença",
                        icon: UIImage(systemName: "fork.knife.circle.fill") ?? UIImage(),
                        firstActionTitle: "Confirmar".uppercased(),
                        firstActionKey: .confirmPresence(willShow: true)),
                        rankingPosition: 8,
                    isAdm: false,
                    menuItems: getMenuItemList(isAdm: false))
            
                completion(user)
        }
    
    func getMenuItemList(isAdm: Bool) -> [MenuItemViewModel] {

        let myData = MenuItemViewModel(
            title: "Meus Dados",
            icon: UIImage(systemName: "folder.badge.person.crop") ?? UIImage(),
            redirectKey: .myData)
        
        let financial = MenuItemViewModel(
            title: "Financeiro",
            icon: UIImage(systemName: "dollarsign.arrow.circlepath") ?? UIImage(),
            redirectKey: .financial)
        
        let calendar = MenuItemViewModel(
            title: "Agenda",
            icon: UIImage(systemName: "calendar") ?? UIImage(),
            redirectKey: .calendar)
        
        let chat = MenuItemViewModel(
            title: "Chat",
            icon: UIImage(systemName: "message.circle") ?? UIImage(),
            redirectKey: .chat)
        
        let ranking = MenuItemViewModel(
            title: "Ranking",
            icon: UIImage(systemName: "trophy.circle") ?? UIImage(),
            redirectKey: .ranking)
        
        let gamesHistory = MenuItemViewModel(
            title: "Jogos",
            icon: UIImage(systemName: "figure.australian.football") ?? UIImage(),
            redirectKey: .games)
        
        let team = MenuItemViewModel(
            title: "Time da semana",
            icon: UIImage(systemName: "tshirt") ?? UIImage(),
            redirectKey: .team)
        
        if !isAdm {
            return [myData, financial, calendar, chat, ranking, gamesHistory, team]
        } else {
            return [myData]
        }
    }
    
}
