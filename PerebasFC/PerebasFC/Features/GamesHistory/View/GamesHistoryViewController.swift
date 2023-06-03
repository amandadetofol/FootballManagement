//
//  GamesHistoryViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 30/05/23.
//

import UIKit

//TODO: VER PQ A VIEW N TA SENDO APRESENTADA
protocol GamesHistoryInteractorProtocol {
    func viewDidLoad()
}

final class GamesHistoryViewController: UIViewController {
    
    private let gamesHistoryView: GamesHistoryView = {
        let view = GamesHistoryView()
   
        return view
    }()
    
    private let interactor: GamesHistoryInteractorProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
        self.view = gamesHistoryView
        self.title = "Histórico de Jogos"
        self.navigationController?.navigationBar.isHidden = false
    }
    
    init(interactor: GamesHistoryInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GamesHistoryViewController: GamesHistoryViewProtocol {
    
    func updateView(using model: [Game]) {
        gamesHistoryView.updateView(with: model)
    }

}
