//
//  GamesHistoryView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 30/05/23.
//

import UIKit

protocol GamesHistoryViewDelegate: AnyObject {
    func handleEditGameButtonTap(game: Game)
}

final class GamesHistoryView: UIView {
    
    weak var delegate: GamesHistoryViewDelegate?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isAccessibilityElement = false
        scrollView.backgroundColor = .clear
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isAccessibilityElement = false
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 64
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 64, left: 0, bottom: -16, right: 0)
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
    
    func updateView(with model: [Game]){
        model.forEach { gameCardModel in
            let card = GameCardView()
            card.delegate = self
            card.updateView(with: gameCardModel)
            stackView.addArrangedSubview(card)
        }
    }
    
    private func setupView(){
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -32),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
        ])
    }
    
}

extension GamesHistoryView: GameCardViewDelegate {
   
    func handleEditGameButtonTap(game: Game) {
        delegate?.handleEditGameButtonTap(game: game)
    }
    
}
