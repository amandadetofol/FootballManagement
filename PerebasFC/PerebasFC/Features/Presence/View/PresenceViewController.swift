//
//  PresenceViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/09/23.
//

import UIKit

protocol PresenceInteractorProtocol {
    func viewDidLoad()
    func handleConfirmButtonTap()
}

final class PresenceViewController: UIViewController {
    
    private lazy var presenceView: PresenceView = {
        let presenceView = PresenceView()
        presenceView.delegate = self
        
        return presenceView
    }()
    
    private let interactor: PresenceInteractorProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = presenceView
        interactor.viewDidLoad()
    }
    
    init(interactor: PresenceInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Lista de Presença"
        handleKeyBoardRemoveWhenClickOutsideField()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}

extension PresenceViewController: PresenceViewDelegate {
    
    func handleConfirmButtonTap() {
        interactor.handleConfirmButtonTap()
    }
    
}

extension PresenceViewController: PresenceViewProtocol {
   
    func updateView(with model: [PresenceCardViewModel]) {
        presenceView.setupView(with: model)
    }
    
}
