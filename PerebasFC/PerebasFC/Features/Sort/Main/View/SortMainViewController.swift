//
//  SortMainViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/08/23.
//

import UIKit

protocol SortMainViewInteractorProtocol {
    func handleNewSort()
    func viewDidLoad()
    func goToSortedGameDetailsView(weekTeam: WeekTeamViewModel)
}

final class SortMainViewController: UIViewController {
  
    private lazy var sortMainView: SortMainView = {
        let sortMainView = SortMainView()
        sortMainView.delegate = self
        
        return sortMainView
    }()
    
    private let interactor: SortMainViewInteractorProtocol
    
    init(interactor: SortMainViewInteractorProtocol) {
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
        view = sortMainView
        self.navigationController?.navigationBar.isHidden = false
        title = "Sorteio"
        self.navigationController?.navigationBar.prefersLargeTitles = true 
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "novo".uppercased(),
            style: .plain,
            target: self,
            action: #selector(handleNewSort))
        handleKeyBoardRemoveWhenClickOutsideField()
    }
    
}

extension SortMainViewController: SortMainViewDelegate {
    
    func goToSortedGameDetailsView(weekTeam: WeekTeamViewModel) {
        interactor.goToSortedGameDetailsView(weekTeam: weekTeam)
    }
    
}

extension SortMainViewController {
    
    @objc func handleNewSort(){
        interactor.handleNewSort()
    }
    
}

extension SortMainViewController: SortMainViewProtocol {
    
    func updateView(with model: SortGameMainViewModel) {
        sortMainView.updateView(with: model)
    }
    
}
