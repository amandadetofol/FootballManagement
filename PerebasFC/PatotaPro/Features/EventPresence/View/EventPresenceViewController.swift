//
//  EventPresenceViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/09/23.
//

import UIKit

protocol EventPresenceInteractorProtocol {
    func viewDidLoad()
}

final class EventPresenceViewController: UIViewController {
    
    private lazy var eventPresenceView: EventPresenceView = {
        let eventPresenceView = EventPresenceView()
     
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
            if self.eventPresenceView.scrollView.frame.origin.y >= 0 {
                self.eventPresenceView.scrollView.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.eventPresenceView.scrollView.frame.origin.y = 0
    }
    
}

extension EventPresenceViewController: EventPresenceViewProtocol {
    
    func updateView(with model: [EventPresenceCardViewModel]) {
        eventPresenceView.setupView(with: model)
    }
    
}
