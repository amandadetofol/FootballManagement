//
//  ChatMainViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 09/06/23.
//

import UIKit

protocol ChatMainInteractorProtocol {
    func viewDidLoad()
    func handleChatItemViewTap(model: ChatItemViewModel)
}

final class ChatMainViewController: UIViewController {
    
    private lazy var chatMainView: ChatMainView = {
        let view = ChatMainView()
        view.delegate = self
        
        return view
    }()
    
    private let interactor: ChatMainInteractorProtocol
    
    init(interactor: ChatMainInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = chatMainView
        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.isHidden = false 
        self.title = "Conversas"
        
        interactor.viewDidLoad()
    }
    
}

extension ChatMainViewController: ChatMainViewDelegate {
    
    func handleChatItemViewTap(model: ChatItemViewModel) {
        interactor.handleChatItemViewTap(model: model)
    }
    
}

extension ChatMainViewController: ChatMainViewProtocol {
    
    func updateView(with model: [ChatItemViewModel]) {
        chatMainView.updateView(with: model)
    }
    
}
