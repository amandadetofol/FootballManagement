//
//  FinancialAdministratorHistoryViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 21/08/23.
//

import UIKit

protocol FinancialAdministratorHistoryInteractorProtocol {
    func viewDidLoad()
    func updateView(basedOn segmentedControlIndex: Int)
}

final class FinancialAdministratorHistoryViewController: UIViewController {
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Todos", "Créditos", "Débitos"])
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
    
    private lazy var financialAdministratorHistoryView: FinancialAdministratorHistoryView = {
        let financialAdministratorHistoryView = FinancialAdministratorHistoryView()
        financialAdministratorHistoryView.translatesAutoresizingMaskIntoConstraints = false 
        
        return financialAdministratorHistoryView
    }()
    
    var model: [FinancialAdministratorHistoryViewModel] = []
    
    private let interactor: FinancialAdministratorHistoryInteractorProtocol
    
    init(interactor: FinancialAdministratorHistoryInteractorProtocol){
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
        self.title = "Histórico"
        
        interactor.viewDidLoad()
        setupSegmentedControl()
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
            if self.financialAdministratorHistoryView.scrollView.frame.origin.y >= 0 {
                self.financialAdministratorHistoryView.scrollView.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.financialAdministratorHistoryView.scrollView.frame.origin.y = 0
    }
    
    
    private func setupSegmentedControl(){
        view.addSubviews([
            segmentedControl,
            financialAdministratorHistoryView])
        
        NSLayoutConstraint.activate([
            segmentedControl.heightAnchor.constraint(equalToConstant: 48),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            
            financialAdministratorHistoryView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            financialAdministratorHistoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            financialAdministratorHistoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            financialAdministratorHistoryView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

extension FinancialAdministratorHistoryViewController {
    
    @objc func segmentedValueChanged(_ sender: UISegmentedControl!) {
        interactor.updateView(basedOn: sender.selectedSegmentIndex)
    }
    
}

extension FinancialAdministratorHistoryViewController: FinancialAdministratorHistoryViewProtocol {
    
    func updateView(with model: [FinancialAdministratorHistoryViewModel]) {
        self.model = model
        updateView(basedOn: 1)
    }
    
    func updateView(basedOn segmentedControlIndex: Int) {
        switch segmentedControlIndex {
            case 0:
                financialAdministratorHistoryView.updateView(with: model)
                
            case 1:
                var items: [FinancialAdministratorHistoryViewModel] = []
                model.forEach { item in
                    if item.operatioType == .credit {
                        items.append(item)
                    }
                }
                financialAdministratorHistoryView.updateView(with: items)
            
            case 2:
                var items: [FinancialAdministratorHistoryViewModel] = []
                model.forEach { item in
                    if item.operatioType == .debit {
                        items.append(item)
                    }
                }
                financialAdministratorHistoryView.updateView(with: items)
                
            default:
                break
        }
    }
    
}
