//
//  HomeInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 25/05/23.
//

import UIKit

protocol HomePresenterProtocol {
    func updateViewForState(isAdm: Bool, model: [MenuItemViewModel])
}

final class HomeInteractor: HomeInteractorProtocol {
    
    private let homeViewModel: [MenuItemViewModel]
    private let presenter: HomePresenterProtocol
    private let coordinator: HomeCoordinatorProtocolWithLoaderProtocol
    
    init(homeViewModel: [MenuItemViewModel],
         presenter: HomePresenterProtocol,
         coordinator: HomeCoordinatorProtocolWithLoaderProtocol) {
        self.homeViewModel = homeViewModel
        self.presenter = presenter
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        presenter.updateViewForState(
            isAdm: Session.shared.isAdm ?? false,
            model: homeViewModel)
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
