//
//  GamesHistoryViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 30/05/23.
//

import UIKit

protocol GamesHistoryInteractorProtocol {
    func viewDidLoad()
    func handleNewGameButtonTap()
    func saveNewGame(game: Game)
    func handleEditGameButtonTap(game: Game)
}

final class GamesHistoryViewController: UIViewController {
    
    private lazy var gamesHistoryView: GamesHistoryView = {
        let view = GamesHistoryView()
        view.delegate = self
   
        return view
    }()
    
    private let interactor: GamesHistoryInteractorProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
        self.view = gamesHistoryView
        self.title = "Histórico de Jogos"
        self.navigationController?.navigationBar.isHidden = false
        
        if Session.shared.isAdm ?? false {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Novo Jogo",
                style: .plain,
                target: self,
                action: #selector(handleNewGameButtonTap))
        }
    }
    
    init(interactor: GamesHistoryInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func saveNewGame(game: Game){
        interactor.saveNewGame(game: game)
    }
    
}

extension GamesHistoryViewController: GamesHistoryViewProtocol {
    
    func updateView(using model: [Game]) {
        gamesHistoryView.updateView(with: model)
    }

}

extension GamesHistoryViewController: GamesHistoryViewDelegate {
    
    func handleEditGameButtonTap(game: Game) {
        interactor.handleEditGameButtonTap(game: game)
    }
    
}

extension GamesHistoryViewController {
    
    @objc func handleNewGameButtonTap(){
        interactor.handleNewGameButtonTap()
    }
    
}
