//
//  ParticipantsManagerCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/08/23.
//

import UIKit

protocol ParticipantsManagerCoordinatorProtocol{
    func openPersonalInformationsView(user: User)
}

final class ParticipantsManagerCoordinator: ParticipantsManagerCoordinatorProtocol {
    
    private let naviagationController: UINavigationController
    
    init(naviagationController: UINavigationController) {
        self.naviagationController = naviagationController
    }
   
    func openPersonalInformationsView(user: User) {
        naviagationController.pushViewController(
            PersonalInformationsFactory.getPersonalInformationsViewController(
                navigationController: naviagationController),
            animated: true)
    }

}
