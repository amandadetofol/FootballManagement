//
//  WelcomeViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 15/05/23.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    private lazy var welcomeView: WelcomeView = {
        let welcomeView = WelcomeView()
        welcomeView.delegate = self
        
        return welcomeView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = welcomeView
        setupNavigationController()
        handleKeyBoardRemoveWhenClickOutsideField()
    }

    private func setupNavigationController(){
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Seja bem-vindo!"
    }

}

extension WelcomeViewController: WelcomeViewDelegate {
    
    func goToLogin() {
        let factory = NewTeamSingUpFactory.getNewTeamSignUpViewController(nagivationController: self.navigationController ?? UINavigationController())
        self.navigationController?.pushViewController(factory, animated: true)
        
        //let loginCoordinator = LoginCoordinator(navigationController: self.navigationController ?? UINavigationController())
        //loginCoordinator.start()
    }

}
