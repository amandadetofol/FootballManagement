//
//  RankingViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 01/06/23.
//

import UIKit

protocol RankingInteractorProtocol {
    func viewDidLoad()
}

final class RankingViewController: UIViewController {
    
    private lazy var rankingView: RankingView = {
        let view = RankingView()
        
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
    
    func updateView(with model: RankingViewModel) {
        rankingView.updateView(with: model)
    }
    
}
