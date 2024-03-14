//
//  RankingViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 01/06/23.
//

import UIKit

protocol RankingInteractorProtocol {
    func viewDidLoad()
    func showUnsufficentPlayersMessage() 
    func handleEditAwardsButtonTap(with model: EditAwardsViewModel)
}

final class RankingViewController: UIViewController {
    
    private lazy var rankingView: RankingView = {
        let view = RankingView()
        view.delegate = self
        
        return view
    }()
    
    private let interactor: RankingInteractorProtocol
    
    init(interactor: RankingInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = rankingView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Ranking"
        self.navigationController?.navigationBar.isHidden = false
        interactor.viewDidLoad()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RankingViewController: RankingViewProtocol {
    
    func showUnsufficentPlayersMessage() {
        interactor.showUnsufficentPlayersMessage()
    }
    
    func updateViewForPricesErrorState() {
        
    }
    
    func updateView(with firebaseDocumentSnapshot: FirstPlaceGiftsViewModel) {
        rankingView.updateAwards(model: firebaseDocumentSnapshot)
    }
    
    func updateView(with model: RankingViewModel) {
        rankingView.updateView(with: model)
    }
    
}

extension RankingViewController: RankingViewDelegate {
   
    func handleEditAwardsButtonTap(model: EditAwardsViewModel) {
        interactor.handleEditAwardsButtonTap(with: model)
    }
    
    func updateAwards(model: FirstPlaceGiftsViewModel){
        rankingView.updateAwards(model: model)
    }
    
}
