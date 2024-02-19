//
//  ParticipantsManagerViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/08/23.
//

import UIKit

protocol ParticipantsManagerInteractorProtocol {
    func viewDidLoad()
    func setupViewForErrorState()
    func handleParticipantCardViewTap(email: String)
    func updateView(basedOn segmentedControlIndex: Int)
}

final class ParticipantsManagerViewController: UIViewController {
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Jogador", "Goleiro", "Participante"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.backgroundColor = Session.shared.highLightColor.withAlphaComponent(0.20)
        
        let titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        
        return segmentedControl
    }()
    
    private lazy var participantsManagerView: ParticipantsManagerView = {
        let participantsManagetView = ParticipantsManagerView()
        participantsManagetView.translatesAutoresizingMaskIntoConstraints = false 
        participantsManagetView.delegate = self
        
        return participantsManagetView
    }()
    
    private let interactor: ParticipantsManagerInteractorProtocol
    private var model: [ParticipantCellModel] = []
    
    init(interactor: ParticipantsManagerInteractorProtocol){
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
        self.title = "Participantes"
        
        setupSegmentedControl()
        interactor.viewDidLoad()
    }
    
    private func setupSegmentedControl(){
        view.addSubviews([segmentedControl, participantsManagerView])
        
        NSLayoutConstraint.activate([
            segmentedControl.heightAnchor.constraint(equalToConstant: 48),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            
            participantsManagerView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            participantsManagerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            participantsManagerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            participantsManagerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

extension ParticipantsManagerViewController: ParticipantsManagerViewDelegate {
   
    func handleParticipantCardViewTap(email: String) {
        interactor.handleParticipantCardViewTap(email: email)
    }
    
}

extension ParticipantsManagerViewController {
    
    @objc func segmentedValueChanged(_ sender: UISegmentedControl!) {
        interactor.updateView(basedOn: sender.selectedSegmentIndex)
    }
    
}

extension ParticipantsManagerViewController: ParticipantsManagerViewProtocol {
    
    func updateViewForErrorState() {
        interactor.setupViewForErrorState()
    }
    
    func updateView(with model: [ParticipantCellModel]) {
        self.model = model
    }
    
    func updateView(basedOn participantType: ParticipantType) {
        var list: [ParticipantCellModel] = []
        self.model.forEach { cardModel in
            if cardModel.user?.type == participantType {
                list.append(cardModel)
            }
        }
        participantsManagerView.updateView(with: list)
    }
    
}
