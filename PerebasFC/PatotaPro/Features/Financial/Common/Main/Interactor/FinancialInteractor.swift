//
//  FinancialInteractor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 12/06/23.
//

import Foundation
import FirebaseFirestore

protocol FinancialPendenciesPresenterProtocol {
    func updateView(basedOn selectIndex: Int)
    func updateView(with model: [QueryDocumentSnapshot]?)
}

final class FinancialInteractor: FinancialPendenciesInteractorProtocol {
    
    private let presenter: FinancialPendenciesPresenterProtocol
    private let coordinator: FinancialCoordinatorProtocol
    private let worker: FinancialWorkerProtocol
    
    init(presenter: FinancialPendenciesPresenterProtocol,
         coordinator: FinancialCoordinatorProtocol,
         worker: FinancialWorkerProtocol) {
        self.presenter = presenter
        self.coordinator = coordinator
        self.worker = worker
    }
    
    func viewDidLoad() {
        worker.getFinancialData { [weak self] data in
            guard let self else { return }
            
            if data?.count == 0 {
                DispatchQueue.main.async {
                    self.coordinator.showEmptyAlert()
                }
                
            } else {
                self.presenter.updateView(with: data)
            }
            
        }
    }
    
    func updateView(basedOn selectIndex: Int) {
        presenter.updateView(basedOn: selectIndex)
    }
    
    func handleFinancialPendencieCardTap(model: FinancialPendencieCardViewModel) {
        coordinator.gotoFinancialDetails(with: model)
    }
    
}
