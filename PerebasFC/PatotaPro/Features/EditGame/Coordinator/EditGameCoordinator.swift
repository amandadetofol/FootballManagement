//
//  EditGameCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/06/23.
//

import UIKit

protocol EditGameCoordinatorProtocol: AnyObject  {
    func handleSaveNewGame(game: Game)
    func handleAddListOfPresenceButtonTap(game: Game)
    func showLoading()
    func removeLoading()
    func showErrorAlert()
}

final class EditGameCoordinator: EditGameCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    private let loader: LoaderCoodinator
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.loader = LoaderCoodinator(navigationController: navigationController)
    }
    
    func handleSaveNewGame(game: Game){
        if let viewController = navigationController.viewControllers.last(where: { $0.isKind(of: GamesHistoryViewController.self) }) {
            guard let vc = viewController as? GamesHistoryViewController else { return }
            vc.saveNewGame(game: game)
            self.navigationController.popToViewController(vc, animated: true)
        }
    }
    
    func handleAddListOfPresenceButtonTap(game: Game){
        navigationController.pushViewController(
            PresenceFactory.getPresenceViewController(
                navigationController: navigationController,
                gameId: game.date.formatData().replacingOccurrences(of: "/", with: "-")),
            animated: true)
    }
    
    func showLoading(){
        loader.showLoader()
    }
    
    func removeLoading(){
        loader.removeLoader()
    }
    
    func showErrorAlert(){
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
    
}
