//
//  ChatMessagesViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 09/06/23.
//

import UIKit

final class ChatMessagesViewController: UIViewController {
    
    private lazy var chatMessageListView: UIView = {
        let view = ChatMessageListView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = chatMessageListView
        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Nome Sobrenome"
    }
    
}
