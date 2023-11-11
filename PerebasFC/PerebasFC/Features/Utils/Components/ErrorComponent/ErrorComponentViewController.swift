//
//  ErrorComponentViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 16/05/23.
//

import UIKit

final class ErrorComponentViewController: UIViewController {
    
    private lazy var errorComponentView: ErrorComponentView = {
        let errorComponentView = ErrorComponentView()
        errorComponentView.delegate = self
        
        return errorComponentView
    }()
    
    private var handleFirstActionButtonTapAction: (()-> Void)?
    private var handleSecondActionButtonTapAction: (()-> Void)?
    
    init(with model: ErrorComponentViewModel,
         handleFirstActionButtonTapAction: (()-> Void)?,
         handleSecondActionButtonTapAction: (()-> Void)?){
        super.init(nibName: nil, bundle: nil)
        title = model.title
        self.handleFirstActionButtonTapAction = handleFirstActionButtonTapAction
        self.handleSecondActionButtonTapAction = handleSecondActionButtonTapAction
        errorComponentView.updateView(with: model)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = errorComponentView
        handleKeyBoardRemoveWhenClickOutsideField()
        view.backgroundColor = .systemBackground
    }
    
}

extension ErrorComponentViewController: ErrorComponentViewDelegate {
    
    func handleFirstActionButtonTap() {
        handleFirstActionButtonTapAction?()
    }
    
    func handleSecondActionButtonTap() {
        handleSecondActionButtonTapAction?()
    }
    
}
