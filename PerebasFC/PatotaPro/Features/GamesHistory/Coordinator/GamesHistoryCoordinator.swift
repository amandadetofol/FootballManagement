//
//  GamesHistoryCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 30/05/23.
//

import UIKit
import EzPopup

protocol GamesHistoryCoordinatorProtocol {
    func showSwipeAlert()
    func showAlertErrorView()
    func goToAddNewGame()
    func goToEditGameView(game: Game)
    func showLoading(_ completion: @escaping(()->Void))
    func removeLoading(_ completion: @escaping(()->Void))
    func showSuccessAddGameAlert()
    func showEmptyAlert()
}

final class GamesHistoryCoordinator: GamesHistoryCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    private let loader: LoaderCoodinator
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.loader = LoaderCoodinator(navigationController: navigationController)
    }
    
    func showSwipeAlert(){
        let contentViewController = SwipeInstructionsViewController()

        let popupVC = PopupViewController(
            contentController: contentViewController,
            popupWidth:300,
            popupHeight: 300)
        popupVC.backgroundAlpha = 0.3
        popupVC.backgroundColor = .black
        popupVC.canTapOutsideToDismiss = true
        popupVC.cornerRadius = 15
        popupVC.shadowEnabled = true
        navigationController.present(popupVC, animated: true)
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
    
    func showLoading(_ completion: @escaping(()->Void)){
        loader.showLoader(completion)
    }
    
    func removeLoading(_ completion: @escaping(()->Void)){
        loader.removeLoader(completion)
    }
    
    func showEmptyAlert(){
        let alert = UIAlertController(
            title: "Nenhum jogo encontrado!",
            message: "Parece que o histórico de jogos da sua patota está vazio. Não se preocupe, assim que o administrador adicionar um jogo no histórico, ele aparecerá aqui.",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default))
        navigationController.present(
            alert,
            animated: true)
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
