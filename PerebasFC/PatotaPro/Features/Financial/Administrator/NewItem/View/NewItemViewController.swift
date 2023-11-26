//
//  NewItemViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 17/08/23.
//

import UIKit

protocol NewItemViewInteractorProtocol {
    func handleConfirmButtonTap(newItem: NewItemModel)
    func handleAddToSpecificPlayerButton()
}

final class NewItemViewController: UIViewController {
    
    private lazy var newItemView: NewItemView = {
        let newItemView = NewItemView()
        newItemView.delegate = self
        
        return newItemView
    }()
    
    var name: String? {
        didSet {
            newItemView.selectedPlayer = name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = newItemView
    }
    
    private let interactor: NewItemViewInteractorProtocol
    
    init(type: NewItemType,
         interactor: NewItemViewInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        newItemView.setupDescription(basedOn: type)
        updateTitle(basedOn: type)
        handleKeyBoardRemoveWhenClickOutsideField()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateTitle(basedOn type: NewItemType){
        self.navigationController?.navigationBar.isHidden = false
        switch type {
            case .credit:
                self.title = "Novo Crédito"
            case .debit:
                self.title = "Novo Débito"
        }
    }
    
}

extension NewItemViewController: NewItemViewDelegate {
    
    func handleConfirmButtonTap(newItem: NewItemModel) {
        interactor.handleConfirmButtonTap(newItem: newItem)
    }
    
    func handleAddToSpecificPlayerButton(){
        interactor.handleAddToSpecificPlayerButton()
    }
}

extension NewItemViewController: NewItemViewProtocol {
    
    func updateViewForDescriptionFieldErrorState() {
        newItemView.nameTextFieldShouldShowError = true
    }
    
    func updateViewForValueFieldErrorState() {
        newItemView.valueTextFieldShouldShowError = true 
    }
    
}
