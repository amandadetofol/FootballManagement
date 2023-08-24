//
//  MapCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 23/08/23.
//

import UIKit

protocol MapCoordinatorProtocol {
    func shareLocalUrl(url: String)
    func goToBack()
    func showConfirmLocaleChangeAlert()
}

final class MapCoordinator: MapCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func shareLocalUrl(url: String){
        let items: [Any] = [
            "Oi! Vim compartilhar a localização da partida de hoje.",
            URL(string: url) as Any]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.navigationController.present(ac, animated: true)
    }
    
    func goToBack() {
        self.navigationController.popViewController(animated: true)
    }
    
    func showConfirmLocaleChangeAlert(){
        let alert = UIAlertController(
            title: "Quer mudar o local do Jogo?",
            message: "Detectamos que você pesquisou um novo local no mapa. \n Deseja atualizar a localização dos jogos para este novo local?",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "Sim",
                style: UIAlertAction.Style.default,
                handler: { [weak self] _ in
                    self?.navigationController.popViewController(animated: true)
                }))
        alert.addAction(
            UIAlertAction(
                title: "Não",
                style: UIAlertAction.Style.destructive,
                handler: { [weak self] _ in
                    self?.navigationController.popViewController(animated: true)
                }))
        navigationController.present(
            alert,
            animated: true)
    }
    
}
