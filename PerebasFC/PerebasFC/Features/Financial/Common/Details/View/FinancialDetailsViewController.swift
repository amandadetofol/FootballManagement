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
         let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.adobe.pdf"], in: .import)
         documentPicker.delegate = self
         documentPicker.allowsMultipleSelection = false
         present(documentPicker, animated: true, completion: nil)
    }
    
}

extension FinancialDetailsViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let fileURL = urls.first {
            // Aqui você pode utilizar o arquivo selecionado, por exemplo:
            // - Armazenar em algum local
            // - Enviar para um servidor
            // - Processar o conteúdo do arquivo
            
            print("Arquivo selecionado: \(fileURL.absoluteString)")
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        // O usuário cancelou a seleção do documento
    }
    
}
