//
//  AdministratorPendenciesViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 19/08/23.
//

import UIKit

protocol AdministratorPendenciesInteractorProtocol {
    func viewDidLoad()
    func updateView(basedOn segmentedControlIndex: Int)
    func handleTitleAndDescriptionCardViewTap(model: FinancialAdministratorPendenciesListCardModel)
}

final class AdministratorPendenciesViewController: UIViewController {
    
    private var model: [FinancialAdministratorPendenciesListCardModel] = []
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Com comprovante", "Sem comprovante",])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.backgroundColor = .systemYellow.withAlphaComponent(0.20)
        
        let titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        
        return segmentedControl
    }()
    
    private lazy var administratorPendenciesView: AdministratorPendenciesView = {
        let administratorPendenciesView = AdministratorPendenciesView()
        administratorPendenciesView.delegate = self
        administratorPendenciesView.translatesAutoresizingMaskIntoConstraints = false
        
        return administratorPendenciesView
    }()
    
    private let interactor: AdministratorPendenciesInteractorProtocol
    
    init(interactor: AdministratorPendenciesInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Pendências"
        
        setupSegmentedControl()
        interactor.viewDidLoad()
        interactor.updateView(basedOn: 1)
        self.view.backgroundColor = .white
        handleKeyBoardRemoveWhenClickOutsideField()
    }
    
    private func setupSegmentedControl(){
        view.addSubviews([segmentedControl, administratorPendenciesView])
        
        NSLayoutConstraint.activate([
            segmentedControl.heightAnchor.constraint(equalToConstant: 48),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            
            administratorPendenciesView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            administratorPendenciesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            administratorPendenciesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            administratorPendenciesView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension AdministratorPendenciesViewController: AdministratorPendenciesViewDelegate {
    
    func handleTitleAndDescriptionCardViewTap(model: FinancialAdministratorPendenciesListCardModel) {
        interactor.handleTitleAndDescriptionCardViewTap(model: model)
    }
    
    @objc func segmentedValueChanged(_ sender: UISegmentedControl!) {
        interactor.updateView(basedOn: sender.selectedSegmentIndex)
    }
    
}

extension AdministratorPendenciesViewController: FinancialAdministratorViewProtocol {
    
    func updateView(basedOn segmentedControlIndex: Int) {
        switch segmentedControlIndex {
            
        case 0:
            var viewModel: [FinancialAdministratorPendenciesListCardModel] = []
            model.forEach { model in
                if model.proofUrl != nil {
                    viewModel.append(model)
                }
            }
            administratorPendenciesView.setupView(with: AdministratorPendenciesViewModel(items: viewModel))
            
        case 1:
            var viewModel: [FinancialAdministratorPendenciesListCardModel] = []
            model.forEach { model in
                if  model.proofUrl == nil {
                    viewModel.append(model)
                }
            }
            administratorPendenciesView.setupView(with: AdministratorPendenciesViewModel(items: viewModel))
            
        default:
            break
            
        }
    }
    
    func updateView(with model: AdministratorPendenciesViewModel) {
        self.model = model.items
    }
    
    
}
