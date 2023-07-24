//
//  EditGameViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/06/23.
//

import UIKit

protocol EditGameInteractorProtocol {
    func viewDidLoad()
    func handleSaveNewGameInformationsButtonTap(game: Game)
}

final class EditGameViewController: UIViewController {
    
    private lazy var editGameView: EditGameView = {
        let view = EditGameView()
        view.delegate = self
        
        return view
    }()
    
    private let interactor: EditGameInteractorProtocol
    
    init(interactor: EditGameInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        title = "Editar Jogo"
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = editGameView
        interactor.viewDidLoad()
    }
    
}

extension EditGameViewController: EditGameViewDelegate {

    func handleSaveNewGameInformationsButtonTap(game: Game) {
        interactor.handleSaveNewGameInformationsButtonTap(game: game)
    }
    
}

extension EditGameViewController: EditGameViewProtocol {
    
    func updateView(with game: Game) {
        editGameView.updateView(with: game)
    }
    
}
