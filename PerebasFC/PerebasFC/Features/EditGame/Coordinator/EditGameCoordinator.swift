//
//  EditGameCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/06/23.
//

import UIKit

protocol EditGameCoordinatorProtocol: AnyObject  {
    func handleSaveNewGame(game: Game)
    func handleAddListOfPresenceButtonTap()
    func handleSaveNewGameInformationsButtonTap(game: Game)
}

final class EditGameCoordinator: EditGameCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func handleSaveNewGameInformationsButtonTap(game: Game) {
        if let viewController = navigationController.viewControllers.last(where: { $0.isKind(of: GamesHistoryViewController.self) }) {
            guard let vc = viewController as? GamesHistoryViewController else { return }
            //tratamento para atualizar o item da lista meu chapa
            self.navigationController.popToViewController(vc, animated: true)
        }
    }
    
    func handleSaveNewGame(game: Game){
        if let viewController = navigationController.viewControllers.last(where: { $0.isKind(of: GamesHistoryViewController.self) }) {
            guard let vc = viewController as? GamesHistoryViewController else { return }
            vc.saveNewGame(game: game)
            self.navigationController.popToViewController(vc, animated: true)
        }
    }
    
    func handleAddListOfPresenceButtonTap(){
        navigationController.pushViewController(
            PresenceFactory.getPresenceViewController(
                navigationController: navigationController),
            animated: true)
    }
    
}
