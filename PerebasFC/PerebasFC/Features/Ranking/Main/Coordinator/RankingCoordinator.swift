//
//  RankingCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import UIKit

protocol RankingCoordinatorProtocol {
    func showAlertErrorPopUp()
    func goToShowEditAwardsView(model: EditAwardsViewModel)
}

final class RankingCoordinator: RankingCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
    
}
