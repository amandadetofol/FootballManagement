//
//  GamesHistoryCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 30/05/23.
//

import UIKit

protocol GamesHistoryCoordinatorProtocol {
    func showAlertErrorView()
    func goToAddNewGame()
    func goToEditGameView(game: Game)
    func showLoading()
    func removeLoading()
    func showSuccessAddGameAlert()
}

final class GamesHistoryCoordinator: GamesHistoryCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    private let loader: LoaderCoodinator
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.loader = LoaderCoodinator(navigationController: navigationController)
    }
    
    func showAlertErrorView() {
        let alert = UIAlertController(
            title: "Ops!",
            message: "Algo deu errado :( ",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default,
                handler: { [weak self] _ in
                    self?.navigationController.popViewController(animated: true)
                }))
        navigationController.present(
            alert,
            animated: true)
    }
    
    func goToEditGameView(game: Game) {
        let controller = EditGameFactory.getEditGameViewController(
            navigationController: self.navigationController,
            model: game,
            isNewGame: false)
        controller.modalPresentationStyle = .pageSheet
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToAddNewGame() {
        let game = Game(score: nil, gameDate: "", goals: nil, date: Date())
        let controller = EditGameFactory.getEditGameViewController(
            navigationController: self.navigationController,
            model: game,
            isNewGame: true)
        controller.title = "Novo Jogo"
        controller.modalPresentationStyle = .pageSheet
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showLoading(){
        loader.showLoader()
    }
    
    func removeLoading(){
        loader.removeLoader()
    }
    
    func showSuccessAddGameAlert(){
        let alert = UIAlertController(
            title: "Novo Jogo!",
            message: "Novo jogo adicionado com sucesso!",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default,
                handler: { [weak self] _ in
                    self?.navigationController.popViewController(animated: true)
                }))
        navigationController.present(
            alert,
            animated: true)
    }
    
}
