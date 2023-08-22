//
//  AdministratorPendenciesDetailsViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 19/08/23.
//

import UIKit

protocol AdministratorPendenciesDetailsInteractorProtocol {
    func viewDidLoad()
    func handleSendNotificationButtonTap()
    func handleConfirmButtonTap(url: String?)
}

final class AdministratorPendenciesDetailsViewController: UIViewController {
    
    private lazy var administratorPendenciesDetailsView: AdministratorPendenciesDetailsView = {
        let administratorPendenciesDetailsView = AdministratorPendenciesDetailsView()
        administratorPendenciesDetailsView.delegate = self
        
        return administratorPendenciesDetailsView
    }()
    
    private let interactor: AdministratorPendenciesDetailsInteractorProtocol
    
    init(interactor: AdministratorPendenciesDetailsInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = administratorPendenciesDetailsView
        interactor.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Detalhes"
    }
    
}

extension AdministratorPendenciesDetailsViewController: AdministratorPendenciesDetailsViewDelegate {
    
    func handleConfirmButtonTap(url: String?) {
        interactor.handleConfirmButtonTap(url: url)
    }
    
    func handleSendNotificationButtonTap() {
        interactor.handleSendNotificationButtonTap()
    }
    
}

extension AdministratorPendenciesDetailsViewController: AdministratorPendenciesDetailsViewProtocol {
    
    func updateView(with model: FinancialAdministratorPendenciesListCardModel) {
        administratorPendenciesDetailsView.updateView(with: model)
    }

}
