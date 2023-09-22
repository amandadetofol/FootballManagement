//
//  FinancialAdministratorMainViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 14/08/23.
//

import UIKit

protocol FinancialAdministratorMainInteractorProtocol {
    func viewDidLoad()
    func handleTitleAndDescriptionCardViewTap(model: FinancialAdministratorActions)
}

final class FinancialAdministratorMainViewController: UIViewController {
    
    private lazy var financialAdministratorMainView: FinancialAdministratorMainView = {
        let financialAdministratorMainView = FinancialAdministratorMainView()
        financialAdministratorMainView.delegate = self
        
        return financialAdministratorMainView
    }()
    
    private let interactor: FinancialAdministratorMainInteractorProtocol
    
    init(interactor: FinancialAdministratorMainInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Financeiro"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.view = financialAdministratorMainView
        interactor.viewDidLoad()
        handleKeyBoardRemoveWhenClickOutsideField()
    }
    
}

extension FinancialAdministratorMainViewController: FinancialAdministratorMainViewDelegate {
    
    func handleTitleAndDescriptionCardViewTap(model: FinancialAdministratorActions) {
        interactor.handleTitleAndDescriptionCardViewTap(model: model)
    }

}

extension FinancialAdministratorMainViewController: FinancialAdministratorMainViewProtocol {
    
    func updateView(with model: FinancialAdministratorMainViewModel) {
        financialAdministratorMainView.setupView(with: model)
    }

}
