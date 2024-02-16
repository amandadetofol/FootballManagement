//
//  HomeInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 25/05/23.
//

import UIKit

protocol HomePresenterProtocol {
    func updateViewForState(isAdm: Bool, model: [MenuItemViewModel])
    func updateViewWith(imageUrl: String, colorname: String)
}

final class HomeInteractor: HomeInteractorProtocol {
    
    private let homeViewModel: [MenuItemViewModel]
    private let presenter: HomePresenterProtocol
    private let coordinator: HomeCoordinatorProtocolWithLoaderProtocol
    private let worker: HomeWorkerProtocol
    private let userDefaultsReference: UserDefaults
    
    init(homeViewModel: [MenuItemViewModel],
         presenter: HomePresenterProtocol,
         coordinator: HomeCoordinatorProtocolWithLoaderProtocol,
         worker: HomeWorkerProtocol) {
        self.homeViewModel = homeViewModel
        self.presenter = presenter
        self.coordinator = coordinator
        self.worker = worker
        self.userDefaultsReference = UserDefaults()
    }
    
    func viewDidLoad() {
        presenter.updateViewForState(
            isAdm: Session.shared.isAdm ?? false,
            model: homeViewModel)
        
        worker.getTeamLogoAndHighlightColor { [weak self] imageUrl, colorname in
            guard let imageUrl,
                  let self else { return }
            
            self.presenter.updateViewWith(imageUrl: imageUrl, colorname: "")
        }
    }
    
    func viewWillAppear() {
        if !UserDefaults.standard.bool(forKey: "firstTimeLogged") {
            coordinator.showFirstTimeLoggedModal()
        }
    }
    
    func handleLogout() {
        coordinator.handleLogout()
    }
    
    func handleAlertCloseButtonTap() {
        coordinator.handleAlertCloseButtonTap()
    }
    
    func handleInternalLinkRedirect(key: InternalLinkRedirectKeys) {
        coordinator.handleInternalLinkRedirect(
            key: key,
            willShow: false)
    }
    
    func handleAccessibilityButtonTap(){
        coordinator.handleAccessibilityButtonTap(
            model:
                [AccessibilityManagerViewModel(
                    title: "Leitor de tela",
                    isActive: UIAccessibility.isVoiceOverRunning),
                 AccessibilityManagerViewModel(
                    title: "Inversão de cores",
                    isActive: UIAccessibility.isInvertColorsEnabled),
                 AccessibilityManagerViewModel(
                    title: "Inversão de cores (daltonismo)",
                    isActive: UIAccessibility.isInvertColorsEnabled),
                ]
        )
    }
    
}
