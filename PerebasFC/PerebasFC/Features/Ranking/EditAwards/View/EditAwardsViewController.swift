//
//  EditAwardsViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 15/06/23.
//

import UIKit

protocol EditAwardsViewInteractorProtocol {
    func viewDidLoad()
    func handleGoToBackButtonTap()
    func handleSetNewAwardsButtonTap(using model: FirstPlaceGiftsViewModel)
}

final class EditAwardsViewController: UIViewController {
    
    private lazy var editAwardsView: EditAwadsView = {
        let view = EditAwadsView()
        view.delegate = self
        
        return view
    }()
    
    private let interactor: EditAwardsViewInteractorProtocol
    
    init(interactor: EditAwardsViewInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = editAwardsView
        interactor.viewDidLoad()
    }
    
}

extension EditAwardsViewController: EditAwadsViewDelegate {
    
    func handleGoToBackButtonTap() {
        interactor.handleGoToBackButtonTap()
    }
    
    func handleSetNewAwardsButtonTap(using model: FirstPlaceGiftsViewModel) {
        interactor.handleSetNewAwardsButtonTap(using: model)
    }
    
}
