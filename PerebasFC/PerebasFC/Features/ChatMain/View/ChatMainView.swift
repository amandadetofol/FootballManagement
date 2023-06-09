//
//  ChatMainView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 09/06/23.
//

import UIKit

protocol ChatMainViewDelegate: AnyObject {
    func handleChatItemViewTap(model: ChatItemViewModel)
}

final class ChatMainView: UIView {
    
    weak var delegate: ChatMainViewDelegate?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isAccessibilityElement = false
        scrollView.isHidden = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.isAccessibilityElement = false
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 32
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 0, bottom: -16, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        
        return stackView
    }()
    
    init(){
        super.init(frame: .zero)
        setupView()
        setupConstraints()
        backgroundColor = .white
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(with model: [ChatItemViewModel]){
        model.forEach { chatItemModel in
            let chatItemCard = ChatItemView(with: chatItemModel)
            chatItemCard.delegate = self 
            stackView.addArrangedSubview(chatItemCard)
        }
    }
    
    private func setupView(){
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -32),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
}

extension ChatMainView: ChatItemViewDelegate {
    
    func handleChatItemViewTap(model: ChatItemViewModel) {
        delegate?.handleChatItemViewTap(model: model)
    }
    
}
