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
}

final class CalendarCoordinator: CalendarCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
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
    
}
