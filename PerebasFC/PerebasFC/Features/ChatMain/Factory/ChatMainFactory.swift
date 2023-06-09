//
//  ChatMainFactory.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 09/06/23.
//

import UIKit

final class ChatMainFactory {
    
    static func getChatMainViewController(navigationController: UINavigationController) -> ChatMainViewController {
        let coordinator = ChatMainCoordinator(navigationController: navigationController)
        let presenter = ChatMainPresenter()
        let worker = ChatMainWorker()
        let interactor = ChatMainInteractor(
            worker: worker,
            presenter: presenter,
            coordinator: coordinator)
        let viewController = ChatMainViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
    
}
