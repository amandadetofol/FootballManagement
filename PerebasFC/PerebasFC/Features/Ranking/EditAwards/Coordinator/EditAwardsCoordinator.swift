//
//  EditAwardsCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 15/06/23.
//

import UIKit

protocol EditAwardsCoordinatorProtocol {
    func goToBack()
    func setNewAwards(with model: FirstPlaceGiftsViewModel)
}

final class EditAwardsCoordinator: EditAwardsCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func goToBack() {
        navigationController.popViewController(animated: true)
    }
    
    func setNewAwards(with model: FirstPlaceGiftsViewModel) {
        if let viewController = navigationController.viewControllers.last(where: { $0.isKind(of: RankingViewController.self) }) {
            guard let vc = viewController as? RankingViewController else { return }
            vc.updateAwards(model: FirstPlaceGiftsViewModel(
                first: model.first,
                second: model.second,
                third: model.third))
            navigationController.popToViewController(vc, animated: true)
        }
    }
    
}
