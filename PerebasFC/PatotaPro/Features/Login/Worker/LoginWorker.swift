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
        id: String,
        _ completion: @escaping (([MenuItemViewModel]?) -> Void))
    func saveCodeFromUserDefaults(code: String)
}

final class LoginWorker: LoginWorkerProtocol {
    
    private let firestoreProvider = Firestore.firestore()
    
    func login(
        username: String,
        password: String,
        id: String,
        _ completion: @escaping (([MenuItemViewModel]?) -> Void)) {
            idExists(id: id) { [weak self] idExists in
                guard let self else { return }
                
                if !idExists {
                    completion(nil)
                } else {
                    self.checkIfUserIsFromThisTeam(email: username, id: id) { isFromThisTeam in
                        if isFromThisTeam {
                            Auth.auth().signIn(
                                withEmail: username,
                                password: password) { [weak self] data, error  in
                                    guard let self = self,
                                          error == nil else {
                                        completion(nil)
                                        return
                                    }
                                    
                                    self.checkIfUserIsAdm(email: username, id: id) { isAdm in
                                        Session.shared.isAdm = isAdm
                                        Session.shared.loggedUserEmail = username
                                        Session.shared.teamId = id
                                        self.saveCodeFromUserDefaults(code: id)
                                    
                                        completion(self.getMenuItemList(isAdm: isAdm))
                                    }
                                }
                        } else {
                            completion(nil)
                        }
                    }
                }
            }
        }
    
    private func idExists(id: String, completion: @escaping ((Bool) -> Void)){
        let db = Firestore.firestore()
        let documentReference = db.collection("team").document(id)
        documentReference.getDocument { (document, error) in
            if let document = document,
               document.exists {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func saveCodeFromUserDefaults(code: String){
        UserDefaults.standard.set(code, forKey: "recentTeamCode")
        UserDefaults.standard.synchronize()
    }
    
    private func checkIfUserIsFromThisTeam(email: String, id: String, completion: @escaping((Bool)-> Void)) {
        firestoreProvider.collection(id).document(email).getDocument { document, error in
            guard error == nil,
                  let email = document?["email"] as? String else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    private func checkIfUserIsAdm(email: String, id: String, completion: @escaping((Bool)-> Void)) {
        firestoreProvider.collection(id).document(email).getDocument { document, error in
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
        
        let deleteTeam = MenuItemViewModel(
            title: "Excluir time",
            icon: UIImage(systemName: "trash.fill") ?? UIImage(),
            redirectKey: .delete)
        
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
            return [myData, admfinancial, calendar, map, chat, ranking, gamesHistory, team, sort, participants, deleteTeam]
        }
    }
    
}
