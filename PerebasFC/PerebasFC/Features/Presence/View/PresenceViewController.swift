//
//  PresenceViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/09/23.
//

import UIKit

protocol PresenceInteractorProtocol {
    func viewDidLoad()
    func handleConfirmButtonTap(model: [PresenceCardViewModel])
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
            if self.presenceView.scrollView.frame.origin.y >= 0 {
                self.presenceView.scrollView.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.presenceView.scrollView.frame.origin.y = 0
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
    
    func handleConfirmButtonTap(model: [PresenceCardViewModel]) {
        interactor.handleConfirmButtonTap(model: model)
    }
    
}

extension PresenceViewController: PresenceViewProtocol {
   
    func updateView(with model: [PresenceCardViewModel]) {
        presenceView.setupView(with: model)
    }
    
}
