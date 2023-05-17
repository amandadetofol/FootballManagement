//
//  LoginCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 16/05/23.
//

import UIKit

protocol LoginCoordinatorProtocol {
    func goToLoginErrorView()
    func goToLoggedArea()
    func goToNewMemeberMessageView()
    func goToForgotPassword(username: String)
}

final class LoginCoordinator: LoginCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start(){
        navigationController.pushViewController(
            LoginFactory.getLoginViewController(navigationController: navigationController),
            animated: true)
    }
    
    func goToLoggedArea() {
        //TODO: Implementar a home
    }
    
    func goToNewMemeberMessageView() {
        let errorView = ErrorComponentViewController(
            with: ErrorComponentViewModel(
                title: "Olá!",
                titleAccessibility: "Olá",
                description: "Gostaríamos de informar que, para se cadastrar como usuário da nossa patota, é necessário entrar em contato com o presidente. Ele é o responsável por realizar o cadastro dos membros.",
                descriptionAccessibility: "Gostaríamos de informar que, para se cadastrar como usuário da nossa patota, é necessário entrar em contato com o presidente. Ele é o responsável por realizar o cadastro dos membros.",
                firstActionName: "📞      Ligar para o administrador",
                firstActionNameAccessibiliyDescription: "Ligar para administrador",
                secondActionName: "✉️       Enviar mensagem no Whatsapp",
                secondActionNameAccessibilityDesctiption: "Enviar mensagem no Whatsapp")) {
                    //DISCADOR
            } handleSecondActionButtonTapAction: {
                //ABRE TELA DO WHATS PRA COMPARTILHAR E ENVIAR MENSAGEM
            }

        
        navigationController.pushViewController(errorView, animated: true )
    }
    
    func goToForgotPassword(username: String) {
        //TODO: Implementar fluxo de mudança de senha 
    }

    func goToLoginErrorView(){
       
    }
    
}
