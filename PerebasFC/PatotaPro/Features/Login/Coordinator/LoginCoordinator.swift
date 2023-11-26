//
//  LoginCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 16/05/23.
//

import UIKit

typealias LoginCoordinatorWithLoaderProtocol = LoaderCoodinatorProtocol & LoginCoordinatorProtocol

protocol LoginCoordinatorProtocol {
    func goToLoginErrorView()
    func goToLoggedArea(_ menuItems: [MenuItemViewModel])
    func goToNewMemeberMessageView()
    func goToForgotPassword(username: String)
}

final class LoginCoordinator: LoginCoordinatorWithLoaderProtocol {

    private let loaderCoordinator: LoaderCoodinator
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.loaderCoordinator = LoaderCoodinator(navigationController: navigationController)
    }
    
    func showLoader() {
        loaderCoordinator.showLoader()
    }
    
    func removeLoader() {
        loaderCoordinator.removeLoader()
    }

    func start(){
        navigationController.pushViewController(
            LoginFactory.getLoginViewController(navigationController: navigationController),
            animated: true)
    }
    
    func goToLoggedArea(_ menuItems: [MenuItemViewModel]) {
        navigationController.pushViewController(
            HomeFactory.getHomeViewController(
                navigationController: self.navigationController,
                menuItems: menuItems),
            animated: true)
    }
    
    func goToNewMemeberMessageView() {
        let viewController = SignUpFactory.getSignUpViewController(navigationController: navigationController)
        navigationController.pushViewController(viewController, animated: true)
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
