//
//  EventPresenceViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/09/23.
//

import UIKit

protocol EventPresenceInteractorProtocol {
    func viewDidLoad()
    func handleConfirmButtonTap()
}

final class EventPresenceViewController: UIViewController {
    
    private lazy var eventPresenceView: EventPresenceView = {
        let eventPresenceView = EventPresenceView()
        eventPresenceView.delegate = self
        
        return eventPresenceView
    }()
    
    private let interactor: EventPresenceInteractorProtocol
    
    init(interactor: EventPresenceInteractorProtocol){
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = eventPresenceView
        interactor.viewDidLoad()
    }
    
}

extension EventPresenceViewController: EventPresenceViewDelegate {
    
    func handleConfirmButtonTap() {
        interactor.handleConfirmButtonTap()
    }
    
}

extension EventPresenceViewController: EventPresenceViewProtocol {
    
    func updateView(with model: [EventPresenceCardViewModel]) {
        eventPresenceView.setupView(with: model)
    }
    
}
