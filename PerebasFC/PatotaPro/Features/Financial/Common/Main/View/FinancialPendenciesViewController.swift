//
//  FinancialPendenciesViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 12/06/23.
//

import UIKit

protocol FinancialPendenciesInteractorProtocol {
    func viewDidLoad()
    func updateView(basedOn selectIndex: Int)
    func handleFinancialPendencieCardTap(model: FinancialPendencieCardViewModel)
}

final class FinancialPendenciesViewController: UIViewController {
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Pendente", "Pago"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.backgroundColor = Session.shared.highLightColor.withAlphaComponent(0.20)
        
        let titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        
        return segmentedControl
    }()
    
    private lazy var financialPendenciesView: FinancialPendenciesView = {
        let view = FinancialPendenciesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        
        return view
    }()
    
    private let interactor: FinancialPendenciesInteractorProtocol
    
    private var model: [FinancialPendencieCardViewModel]?
    
    init(interactor: FinancialPendenciesInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Financeiro"
        
        setupSegmentedControl()
        interactor.viewDidLoad()
        handleKeyBoardRemoveWhenClickOutsideField()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.financialPendenciesView.scrollView.frame.origin.y >= 0 {
                self.financialPendenciesView.scrollView.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.financialPendenciesView.scrollView.frame.origin.y = 0
    }
    
    private func setupSegmentedControl(){
        view.addSubviews([segmentedControl, financialPendenciesView])
        
        NSLayoutConstraint.activate([
            segmentedControl.heightAnchor.constraint(equalToConstant: 48),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            
            financialPendenciesView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            financialPendenciesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            financialPendenciesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            financialPendenciesView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

extension FinancialPendenciesViewController: FinancialPendenciesViewDelegate {
    
    func handleFinancialPendencieCardTap(model: FinancialPendencieCardViewModel) {
        interactor.handleFinancialPendencieCardTap(model: model)
    }
    
}

extension FinancialPendenciesViewController {
    
    @objc func segmentedValueChanged(_ sender: UISegmentedControl!) {
        interactor.updateView(basedOn: sender.selectedSegmentIndex)
    }
    
}

extension FinancialPendenciesViewController: FinancialViewProtocol {
    
    func updateViewForPayed() {
        var list: [FinancialPendencieCardViewModel] = []
        self.model?.forEach({ cardModel in
            if cardModel.admAprooved {
                list.append(cardModel)
            }
        })
        
        
        self.financialPendenciesView.updateView(with: list)
    }
    
    func updateViewForPendencie() {
        var list: [FinancialPendencieCardViewModel] = []
        self.model?.forEach({ cardModel in
            if !cardModel.admAprooved {
                list.append(cardModel)
            }
        })
        self.financialPendenciesView.updateView(with: list)
    }
    
    func updateView(with model: [FinancialPendencieCardViewModel]) {
        self.model = model
        updateViewForPayed()
    }

}
