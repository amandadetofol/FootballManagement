//
//  RankingCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import UIKit

protocol RankingCoordinatorProtocol {
    func showLoading(_ completion: @escaping(()->Void))
    func dissmissLoading(_ completion: @escaping(()->Void))
    func showAlertErrorPopUp()
    func goToShowEditAwardsView(model: EditAwardsViewModel)
    func showUnsufficentPlayersMessage()
}

final class RankingCoordinator: RankingCoordinatorProtocol {

    private let loader: LoaderCoodinator
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.loader = LoaderCoodinator(navigationController: navigationController)
    }
    
    func showAlertErrorPopUp(){
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
    
    func goToShowEditAwardsView(model: EditAwardsViewModel){
        navigationController.pushViewController(
            EditAwardsFactory.getEditAwardsViewController(
                navigationController: navigationController,
                model: model),
            animated: true)
    }
    
    func showLoading(_ completion: @escaping(()->Void)){
        loader.showLoader(completion)
    }
    
    func dissmissLoading(_ completion: @escaping(()->Void)){
        loader.removeLoader(completion)
    }
    
    func showUnsufficentPlayersMessage(){
        let alert = UIAlertController(
            title: "Ops!",
            message: "Para visualizar o ranking, você precisa ter no mínimo 3 membros no time. No entanto, você pode alterar as premiações.",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: UIAlertAction.Style.default,
                handler: { [weak self] _ in
                    self?.navigationController.popViewController(animated: true)
                }))
        navigationController.present(
            alert,
            animated: true)
    }
    
}
