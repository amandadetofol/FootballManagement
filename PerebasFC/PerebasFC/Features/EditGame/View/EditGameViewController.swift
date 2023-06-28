//
//  EditGameViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/06/23.
//

import UIKit

protocol EditGameInteractorProtocol {
    func viewDidLoad()
    func handleGoToBackButtonTap()
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
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = editGameView
    }
    
}

extension EditGameViewController: EditGameViewDelegate {
    
    func handleGoToBackButtonTap() {
        interactor.handleGoToBackButtonTap()
    }
    
    func handleSaveNewGameInformationsButtonTap(game: Game) {
        interactor.handleSaveNewGameInformationsButtonTap(game: game)
    }
    
}
