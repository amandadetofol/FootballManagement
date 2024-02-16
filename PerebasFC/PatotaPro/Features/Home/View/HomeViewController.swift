//
//  HomeViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 24/05/23.
//

import UIKit

protocol HomeInteractorProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func handleLogout()
    func handleAccessibilityButtonTap()
    func handleAlertCloseButtonTap()
    func handleInternalLinkRedirect(key: InternalLinkRedirectKeys)
}

final class HomeViewController: UIViewController {
    
    private lazy var homeView: HomeView = {
        let homeView = HomeView()
        homeView.delegate = self
        
        return homeView
    }()
    
    private let interactor: HomeInteractorProtocol
    
    init(interactor: HomeInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
        self.view = homeView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        interactor.viewWillAppear()
    }
    
}

extension HomeViewController: HomeViewProtocol {
    
    func updateViewWith(imageUrl: String, colorname: String) {
        homeView.updateViewWith(imageUrl: imageUrl, colorname: colorname)
    }
    
    func updateViewForState(isAdm: Bool, model: HomeViewModel) {
        homeView.updateView(viewModel: model)
    }
    
}

extension HomeViewController: HomeViewDelegate {
    
    func handleAccessibilityButtonTap(){
        interactor.handleAccessibilityButtonTap()
    }
   
    func handleLogout() {
        interactor.handleLogout()
    }
    
    func handleAlertCloseButtonTap() {
        interactor.handleAlertCloseButtonTap()
    }
    
    func handleInternalLinkRedirect(key: InternalLinkRedirectKeys) {
        interactor.handleInternalLinkRedirect(key: key)
    }
    
}
