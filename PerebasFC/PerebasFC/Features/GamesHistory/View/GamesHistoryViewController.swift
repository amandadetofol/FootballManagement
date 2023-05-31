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
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let interactor: GamesHistoryInteractorProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
        view.addSubview(gamesHistoryView)
        setupConstraints()
    }
    
    init(interactor: GamesHistoryInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        self.title = "Histórico de Jogos"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            gamesHistoryView.topAnchor.constraint(equalTo: view.topAnchor, constant: 108),
            gamesHistoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gamesHistoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gamesHistoryView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

extension GamesHistoryViewController: GamesHistoryViewProtocol {
    
    func updateView(using model: [Game]) {
        gamesHistoryView.updateView(with: model)
    }

}
