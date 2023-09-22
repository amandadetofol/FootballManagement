//
//  ParticipantsSelectorListViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 04/09/23.
//

import UIKit

protocol ParticipantsSelectorListViewInteractorProtocol {
    func viewDidLoad()
    func handleParticipantsSelectorCardViewTap(name: String)
}

final class ParticipantsSelectorListViewController: UIViewController {
    
    private lazy var participantsSelectorListView: ParticipantsSelectorListView = {
        let participantsSelectorListView = ParticipantsSelectorListView()
        participantsSelectorListView.delegate = self
        
        return participantsSelectorListView
    }()
    
    private let interactor: ParticipantsSelectorListViewInteractorProtocol
    
    init(interactor: ParticipantsSelectorListViewInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
        self.view = participantsSelectorListView
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Lista de Jogadores"
        handleKeyBoardRemoveWhenClickOutsideField()
    }
    
}

extension ParticipantsSelectorListViewController: ParticipantsSelectorListViewDelegate {
    
    func handleParticipantsSelectorCardViewTap(name: String) {
        interactor.handleParticipantsSelectorCardViewTap(name: name)
    }

}

extension ParticipantsSelectorListViewController: ParticipantsSelectorListViewProtocol {
    
    func updateView(model: [ParticipantsSelectorCardViewModel]) {
        participantsSelectorListView.updateView(with: model)
    }
    
}
