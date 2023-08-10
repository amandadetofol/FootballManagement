//
//  LoginWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 16/05/23.
//

import UIKit
import Firebase
import GoogleSignIn

protocol LoginWorkerProtocol {
    func login(
        username: String,
        password: String,
        isAdm: Bool,
        _ completion: @escaping ((User?) -> Void))
    func loginWithGoogle(
        controller: UIViewController,
        isAdm: Bool,
        _ completion: @escaping ((User?) -> Void))
}

final class LoginWorker: LoginWorkerProtocol {
    
    func loginWithGoogle(
        controller: UIViewController,
        isAdm: Bool = false,
        _ completion: @escaping ((User?) -> Void)) {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config
            
            GIDSignIn.sharedInstance.signIn(withPresenting: controller) { [unowned self] result, error in
                guard error == nil,
                      let user = result?.user,
                      let idToken = user.idToken?.tokenString else {
                    completion(nil)
                    return
                }
                
                let credential = GoogleAuthProvider.credential(
                    withIDToken: idToken,
                    accessToken: user.accessToken.tokenString)
                
                Auth.auth().signIn(with: credential) { result, error in
                    if (result?.user != nil) {
                        Session.shared.isAdm = isAdm
                        completion(self.getMockUser(isAdm: isAdm))
                    } else {
                        completion(nil)
                    }
                }
            }
        }
    
    func login(
        username: String,
        password: String,
        isAdm: Bool,
        _ completion: @escaping ((User?) -> Void)) {
            
            Auth.auth().signIn(
                withEmail: username,
                password: password) { [weak self] data, error  in
                    guard let self = self,
                          error == nil else {
                        completion(nil)
                        return
                    }
                    
                    if (data?.user != nil) {
                        Session.shared.isAdm = isAdm
                        completion(getMockUser(isAdm: isAdm))
                    } else {
                        completion(nil)
                    }
                    
                }
        }
    
}

extension LoginWorker {
    
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
        
        let sort = MenuItemViewModel(
            title: "Sorteios",
            icon: UIImage(systemName: "die.face.5.fill") ?? UIImage(),
            redirectKey: .sort)
        
        let participants = MenuItemViewModel(
            title: "Participantes",
            icon: UIImage(systemName: "person.3.sequence.fill") ?? UIImage(),
            redirectKey: .participants)
        
        if !isAdm {
            return [myData, financial, calendar, chat, ranking, gamesHistory, team]
        } else {
            return [myData, financial, calendar, chat, ranking, gamesHistory, team, sort, participants]
        }
    }
    
    //TODO: Remove mock when finish integration
    private func getMockUser(isAdm: Bool) -> User {
        Session.shared.isAdm = isAdm
        return User(
            id: "01",
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
            type: .goalKepper,
            menuItems: self.getMenuItemList(isAdm: isAdm))
    }
}
