//
//  LoginCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 16/05/23.
//

import UIKit

protocol LoginCoordinatorProtocol {
    func goToLoginErrorView()
    func goToLoggedArea(user: User)
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
    
    func goToLoggedArea(user: User) {
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
                secondActionNameAccessibilityDesctiption: "Enviar mensagem no Whatsapp")) { [weak self] in
                    guard let self = self else { return }
                    self.callNumber()
            } handleSecondActionButtonTapAction: { [weak self] in
                guard let self = self else { return }
                self.showNativeShare()
            }

        
        navigationController.pushViewController(errorView, animated: true )
    }
    
    func goToForgotPassword(username: String) {
        let viewConroller = ForgotPasswordFactory.getForgotPasswordViewController(
            navigationController: navigationController,
            email: username)
        self.navigationController.pushViewController(viewConroller, animated: true)
    }
    
    func goToLoginErrorView() {
        let alert = UIAlertController(
            title: "Ops!",
            message: "Algo deu errado :( \n Revise seus dados e tente novamente!",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default,
                handler: nil))
        navigationController.present(
            alert,
            animated: true)
    }
    
    private func showNativeShare() {
        let urlWhats = "whatsapp://send?phone=+5547996263863&abid=12354&text=Hello"
            if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
                if let whatsappURL = URL(string: urlString) {
                    if UIApplication.shared.canOpenURL(whatsappURL) {
                        UIApplication.shared.open(whatsappURL)
                    }
                }
            }
    }
    
    private func callNumber(){
        let phoneNumber = "+5547996263863"
        let numberUrl = URL(string: "tel://\(phoneNumber)")!
        if UIApplication.shared.canOpenURL(numberUrl) {
            UIApplication.shared.open(numberUrl)
        }
    }
    
}
