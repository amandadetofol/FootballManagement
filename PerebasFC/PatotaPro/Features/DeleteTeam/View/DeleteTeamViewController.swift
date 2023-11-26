//
//  DeleteTeamViewController.swift
//  PatotaPro
//
//  Created by Amanda Detofol on 26/11/23.
//

import UIKit

protocol DeleteTeamInteractorProtocol {
    func viewDidLoad()
    func handleConfirmButtonTap(id: String)
}

final class DeleteTeamViewController: UIViewController {
    
    private lazy var deleteTeamView: DeleteTeamView = {
        let view = DeleteTeamView()
        view.delegate = self
        
        return view
    }()
    
    private let interactor: DeleteTeamInteractorProtocol
    
    init(interactor: DeleteTeamInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        title = "Exluir patota"
        
        view = deleteTeamView
        interactor.viewDidLoad()
    }
    
}

extension DeleteTeamViewController: DeleteTeamViewProtocol {
   
    func updateView(with model: DeleteTeamViewModel) {
        deleteTeamView.updateView(with: model)
    }
    
}

extension DeleteTeamViewController: DeleteTeamViewDelegate {
   
    func handleConfirmButtonTap(id: String) {
        interactor.handleConfirmButtonTap(id: id)
    }
    
}
