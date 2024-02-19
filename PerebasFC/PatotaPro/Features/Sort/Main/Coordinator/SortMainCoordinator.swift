//
//  SortMainCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/08/23.
//

import UIKit
import EzPopup

protocol SortMainCoordinatorProtocol {
    func showSwipeAlert()
    func showSuccessPopUp(model: WeekTeamViewModel)
    func showErrorPopUp()
    func showLoading(_ completion: @escaping(()->Void))
    func removeLoading(_ completion: @escaping(()->Void))
    func goToWeekTeamView(model: WeekTeamViewModel)
}

final class SortMainCoordinator: SortMainCoordinatorProtocol {
    
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
    
    func goToWeekTeamView(model: WeekTeamViewModel){
        let controller = WeekTeamFactory.getWeekTeamViewController(
            teams: model,
            shouldCallApi: false,
            navigationController: navigationController)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showSuccessPopUp(model: WeekTeamViewModel){
        let alert = UIAlertController(
            title: "Novos Times Sorteados",
            message: "Novos times sorteados com sucesso. Confira clicando em OK. ;)",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default,
                handler: { [weak self] _ in
                    self?.goToWeekTeamView(
                        model: model)
                }))
        alert.addAction(
            UIAlertAction(
                title: "Fechar",
                style: UIAlertAction.Style.destructive,
                handler: { [weak self] _ in
                    self?.navigationController.popViewController(animated: true)
                }))
        navigationController.present(
            alert,
            animated: true)
    }
    
    func showErrorPopUp() {
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
    
    func showLoading(_ completion: @escaping(()->Void)){
        loader.showLoader(completion)
    }
    
    func removeLoading(_ completion: @escaping(()->Void)){
        loader.removeLoader(completion)
    }
    
}
