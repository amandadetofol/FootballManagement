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
    func showConfirmationPopUp()
    func goToSeePresenceList()
    func showErrorAlert()
    func showLoading()
    func removeLoading()
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
    
    func showConfirmationPopUp() {
        let alert = UIAlertController(
            title: "Confirmar presença.",
            message: "Deseja confirmar presença?",
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
                style: UIAlertAction.Style.cancel,
                handler: { [weak self] _ in
                    self?.navigationController.popViewController(animated: true)
                }))
        navigationController.present(
            alert,
            animated: true)
    }
    
    func goToSeePresenceList() {
        self.navigationController.pushViewController(
            EventPresenceFactory.getEventPresenceViewController(
                navigationController: navigationController),
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
    
    func showLoading(){
        loader.showLoader()
    }
    
    func removeLoading(){
        loader.removeLoader()
    }
    
    
}
