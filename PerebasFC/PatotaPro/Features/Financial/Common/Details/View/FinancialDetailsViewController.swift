//
//  FinancialDetailsViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 13/06/23.
//

import UIKit

protocol FinancialDetailsInteractorProtocol {
    func viewDidLoad()
    func handleAddProofButtonTap()
    func addNewProof(itemId: Int, data: Data)
}

final class FinancialDetailsViewController: UIViewController {
    
    private lazy var financialDetailsView: FinancialDetailsView = {
        let financialDetailsView = FinancialDetailsView()
        financialDetailsView.delegate = self
        
        return financialDetailsView
    }()
    
    private let interactor: FinancialDetailsInteractorProtocol
    
    init(interactor: FinancialDetailsInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        title = "Detalhes"
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = financialDetailsView
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
            if self.financialDetailsView.scrollView.frame.origin.y >= 0 {
                self.financialDetailsView.scrollView.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.financialDetailsView.scrollView.frame.origin.y = 0
    }
    
}

extension FinancialDetailsViewController: FinancialDetailsViewDelegate {
    
    func handleAddProofButtonTap() {
        interactor.handleAddProofButtonTap()
    }
    
}

extension FinancialDetailsViewController: FinancialDetailsViewProtocol {
    
    func updateView(with model: FinancialDetailsViewModel) {
        financialDetailsView.updateView(with: model)
    }
    
    func showAddNewProofItem() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.content"], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
    
}

extension FinancialDetailsViewController: UIDocumentPickerDelegate {
    
    func documentPicker(
        _ controller: UIDocumentPickerViewController,
        didPickDocumentsAt urls: [URL]) {
            guard let selectedFileURL = urls.first else { return }
            do {
                let fileData = try Data(contentsOf: selectedFileURL)
                interactor.addNewProof(
                    itemId: financialDetailsView.index ?? 0,
                    data: fileData)
            } catch {
                return
            }
        }
}
