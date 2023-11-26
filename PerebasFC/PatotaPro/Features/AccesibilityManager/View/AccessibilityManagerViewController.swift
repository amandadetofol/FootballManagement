//
//  AccessibilityManagerViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 13/08/23.
//

import UIKit

protocol AccessibilityManagerInteractorProtocol {
    func viewDidLoad()
    func didTapButton()
}

final class AccessibilityManagerViewController: UIViewController {
    
    private lazy var accessibilityManagerView: AccessibilityManagerView = {
        let accessibilityManagerView = AccessibilityManagerView()
        accessibilityManagerView.translatesAutoresizingMaskIntoConstraints = false
        accessibilityManagerView.delegate = self
        
        return accessibilityManagerView
    }()
    
    private let interactor: AccessibilityManagerInteractorProtocol
    
    init(interactor: AccessibilityManagerInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(accessibilityManagerView)
        setupConstraints()
        interactor.viewDidLoad()
        handleKeyBoardRemoveWhenClickOutsideField()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            accessibilityManagerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            accessibilityManagerView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.width + 100),
            accessibilityManagerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            accessibilityManagerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
}

extension AccessibilityManagerViewController: AccessibilityManagerViewDelegate {
    
    func didTapButton(){
        interactor.didTapButton()
    }
    
}

extension AccessibilityManagerViewController: AccessibilityManagerViewProtocol {
    
    func updatView(with model: [AccessibilityManagerViewModel]) {
        accessibilityManagerView.updateView(accessibilityOptions: model)
    }
    
}
