//
//  SortMainCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/08/23.
//

import UIKit

protocol SortMainCoordinatorProtocol {
    func showSuccessPopUp()
    func showErrorPopUp()
    func showLoading()
    func removeLoading()
    func goToWeekTeamView(model: WeekTeamViewModel)
}

final class SortMainCoordinator: SortMainCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    private let loader: LoaderCoodinator
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.loader = LoaderCoodinator(navigationController: navigationController)
    }
    
    func goToWeekTeamView(model: WeekTeamViewModel){
        let controller = WeekTeamFactory.getWeekTeamViewController(teams: model)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showSuccessPopUp(){
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
                        model: WeekTeamViewModel(
                        whiteTeam: Team(players: Session.shared.players),
                        blackTeam: Team(players: Session.shared.players)))
                }))
        alert.addAction(
            UIAlertAction(
                title: "fechar".uppercased(),
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
    
    func showLoading(){
        loader.showLoader()
    }
    
    func removeLoading(){
        loader.removeLoader()
    }
    
}
