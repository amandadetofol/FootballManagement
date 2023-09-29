//
//  LoginWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 16/05/23.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseFirestore

protocol LoginWorkerProtocol {
    func login(
        username: String,
        password: String,
        _ completion: @escaping (([MenuItemViewModel]?) -> Void))
    func loginWithGoogle(
        controller: UIViewController,
        _ completion: @escaping (([MenuItemViewModel]?) -> Void))
}

final class LoginWorker: LoginWorkerProtocol {
    
    private let firestoreProvider = Firestore.firestore()
    
    func loginWithGoogle(
        controller: UIViewController,
        _ completion: @escaping ([MenuItemViewModel]?) -> Void) {
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
                        Session.shared.isAdm = false
                        completion(self.getMenuItemList(isAdm: false))
                    } else {
                        completion(nil)
                    }
                }
            }
        }
    
    func login(
        username: String,
        password: String,
        _ completion: @escaping (([MenuItemViewModel]?) -> Void)) {
            
            Auth.auth().signIn(
                withEmail: username,
                password: password) { [weak self] data, error  in
                    guard let self = self,
                          error == nil else {
                        completion(nil)
                        return
                    }
                
                    self.checkIfUserIsAdm(email: username) { isAdm in
                        Session.shared.isAdm = isAdm
                        Session.shared.loggedUserEmail = username
                        completion(self.getMenuItemList(isAdm: isAdm))
                    }

                }
        }
    
    private func checkIfUserIsAdm(email: String, completion: @escaping((Bool)-> Void)) {
        firestoreProvider.collection("perebasfc").document(email).getDocument { document, error in
            guard error == nil else {
                completion(false)
                return
            }
            completion(document?["isAdm"] as? Bool ?? false)
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
        
        let admfinancial = MenuItemViewModel(
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
        
        let map = MenuItemViewModel(
            title: "Local do Jogo",
            icon: UIImage(systemName: "map.fill") ?? UIImage(),
            redirectKey: .map)
        
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
            return [myData, financial, calendar, map, chat, ranking, gamesHistory, team]
        } else {
            return [myData, admfinancial, calendar, map, chat, ranking, gamesHistory, team, sort, participants]
        }
    }
    
}
