//
//  NewTeamSignUpCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 04/11/23.
//

import UIKit

protocol NewTeamSignUpCoordinatorProtocol {
    func showErrorAlertView()
    func goToUserLogin()
    func showLoading()
    func removeLoading()
    func showIdAlertView(id: String)
    func showColorContrastProblemAlert()
}

final class NewTeamSignUpCoordinator: NewTeamSignUpCoordinatorProtocol {
    
    private let loadingCoordinator: LoaderCoodinatorProtocol
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.loadingCoordinator = LoaderCoodinator(navigationController: navigationController)
    }
    
    func showColorContrastProblemAlert(){
        let alert = UIAlertController(
            title: "Baixo contraste! \n",
            message: """
    O que isso quer dizer?

    Cores de contraste baixo dificultam a leitura, requerem mais esforço visual e prejudicam a acessibilidade.\n
    O contraste apropriado entre texto e fundo é vital para a legibilidade do conteúdo.\n
    Cores de baixo contraste podem causar dificuldades, tornando a experiência menos inclusiva e prejudicando a compreensão.\n
    Escolha uma nova cor que não será prejudicial a saúde da sua visão ;) 
""",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "Ok!",
                style: UIAlertAction.Style.default))
        navigationController.present(
            alert,
            animated: true)
    }
    
    func showIdAlertView(id: String){
        let alert = UIAlertController(
            title: "Sucesso!",
            message: "Nova equipe cadastrada. \n\n Para acessar, copie o código abaixo: \n\n \(id) \n\n  Fique atento: ele não será exibido novamente! Salve em algum local ;) ",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "Ir para o login",
                style: .default,
                handler: { _ in
                    self.goToUserLogin()
                }))
        navigationController.present(
            alert,
            animated: true)
    }
    
    func showErrorAlertView(){
        let alert = UIAlertController(
            title: "Ops! Algo deu errado :(",
            message: "Tente novamente!",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: UIAlertAction.Style.default))
        navigationController.present(
            alert,
            animated: true)
    }
    
    func goToUserLogin(){
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.start()
    }
    
    func showLoading(){
        loadingCoordinator.showLoader()
    }
    
    func removeLoading(){
        loadingCoordinator.removeLoader()
    }
    
}
