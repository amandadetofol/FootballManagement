//
//  WeekTeamCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 01/10/23.
//

import UIKit

protocol WeekTeamCoordinatorProtocol {
    func showLoading()
    func removeLoading()
    func showErrorView()
}

final class WeekTeamCoordinator: WeekTeamCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    private let loader: LoaderCoodinator
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.loader = LoaderCoodinator(navigationController: navigationController)
    }
    
    func showLoading(){
        loader.showLoader()
    }
    
    func removeLoading(){
        loader.removeLoader()
    }
    
    func showErrorView(){
        let alert = UIAlertController(
            title: "Ops! :(",
            message: "Não encontramos nenhum time disponível para essa semana!",
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
