//
//  ChatMainInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 09/06/23.
//

import Foundation

protocol ChatMainPresenterProtocol {
    func updateView(with model: [ChatItemViewModel])
}

final class ChatMainInteractor: ChatMainInteractorProtocol {
    
    private let worker: ChatMainWorkerProtocol
    private let presenter: ChatMainPresenterProtocol
    private let coordinator: ChatMainCoordinatorProtocol
    
    init(
        worker: ChatMainWorkerProtocol,
        presenter: ChatMainPresenterProtocol,
        coordinator: ChatMainCoordinatorProtocol) {
            self.worker = worker
            self.presenter = presenter
            self.coordinator = coordinator
        }
    
    func viewDidLoad() {
        worker.getChat { [weak self] data in
            guard let data = data else {
                self?.coordinator.showErrorAlertView()
                return
            }
            self?.presenter.updateView(with: data)
        }
    }
    
    func handleChatItemViewTap(model: ChatItemViewModel) {
        coordinator.goToChatDetails(model: model.chat)
    }
    
}
