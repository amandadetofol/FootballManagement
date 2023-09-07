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
}

final class GamesHistoryCoordinator: GamesHistoryCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
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
    
}
