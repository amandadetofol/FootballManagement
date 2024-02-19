//
//  CalendarCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 12/06/23.
//

import UIKit

protocol CalendarCoordinatorProtocol {
    func goToBack()
    func goToCreateNewEvent(date: Date)
    func showConfirmationPopUp(
        numberOfCompanions: Int,
        completion: @escaping((Bool, Int?)->Void))
    func goToSeePresenceList(itemId: String)
    func showErrorAlert()
    func showLoading(_ completion: @escaping(()->Void))
    func removeLoading(_ completion: @escaping(()->Void))
    func showSuccessAlert()
}

final class CalendarCoordinator: CalendarCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    private let loader: LoaderCoodinator
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.loader = LoaderCoodinator(navigationController: navigationController)
    }
    
    func goToBack() {
        navigationController.popViewController(animated: true)
    }
    
    func goToCreateNewEvent(date: Date) {
        navigationController.pushViewController(
            NewEventInCalendarFactory.getNewEventInCalendarViewController(
                navigationController: navigationController,
                date: date),
            animated: true)
    }
    
    func showConfirmationPopUp(
        numberOfCompanions: Int,
        completion: @escaping((Bool, Int?)->Void)){
        let alert = UIAlertController(
            title: "Confirmar presença.",
            message: "Deseja confirmar presença?",
            preferredStyle: UIAlertController.Style.alert)
            
            if numberOfCompanions > 0 {
                alert.addTextField { textField in
                    textField.placeholder = "Número de acompanhantes"
                }
            }
    
        alert.addAction(
            UIAlertAction(
                title: "Sim",
                style: UIAlertAction.Style.default,
                handler: { _ in
                    completion(true, Int(alert.textFields?.first?.text ?? "0"))
                }))
        
        alert.addAction(
            UIAlertAction(
                title: "Não",
                style: UIAlertAction.Style.cancel,
                handler: { _ in
                    completion(false, Int(alert.textFields?.first?.text ?? "0"))
                }))
            
        navigationController.present(
            alert,
            animated: true)
    }
    
    func showSuccessAlert(){
        let alert = UIAlertController(
            title: "Presença confirmada.",
            message: "",
            preferredStyle: UIAlertController.Style.alert)
    
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.cancel))
            
        navigationController.present(
            alert,
            animated: true)
    }
    
    func goToSeePresenceList(itemId: String) {
        self.navigationController.pushViewController(
            EventPresenceFactory.getEventPresenceViewController(
                navigationController: navigationController,
                itemId: itemId),
            animated: false)
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
    
    func showLoading(_ completion: @escaping(()->Void)){
        loader.showLoader(completion)
    }
    
    func removeLoading(_ completion: @escaping(()->Void)){
        loader.removeLoader(completion)
    }
    
    
}
