//
//  ParticipantsManagerView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/08/23.
//

import UIKit

protocol ParticipantsManagerViewDelegate: AnyObject {
    func handleParticipantCardViewTap(user: User)
}

final class ParticipantsManagerView: UIView {
    
    weak var delegate: ParticipantsManagerViewDelegate?
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isAccessibilityElement = false
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isAccessibilityElement = false
        scrollView.backgroundColor = .clear
        
        return scrollView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        
        return stackView
    }()
    
    
    init(){
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(with model: [ParticipantCellModel]){
        model.forEach { participantCellModel in
            let card = PariticipantCellView()
            card.updateView(with: participantCellModel)
            card.delegate = self
            contentStackView.addArrangedSubview(card)
        }
    }
    
    private func setupView(){
        addSubview(contentView)
        contentView.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        backgroundColor = .white
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }
    
}

extension ParticipantsManagerView: ParticipantCellViewDelegate {
    
    func handleParticipantCardViewTap(user: User) {
        delegate?.handleParticipantCardViewTap(user: user)
    }

}
