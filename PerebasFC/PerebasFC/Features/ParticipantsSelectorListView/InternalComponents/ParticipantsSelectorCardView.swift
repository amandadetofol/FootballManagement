//
//  ParticipantsSelectorCardView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 04/09/23.
//

import UIKit

protocol ParticipantsSelectorCardViewDelegate: AnyObject {
    func handleParticipantsSelectorCardViewTap(name: String)
}

final class ParticipantsSelectorCardView: UIControl {
    
    weak var delegate: ParticipantsSelectorCardViewDelegate?
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.isAccessibilityElement = false
        
        return label
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.isAccessibilityElement = false
        
        return view
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
    
    func updateView(model: ParticipantsSelectorCardViewModel){
        nameLabel.text = model.title
    }
    
    func updateAccessibility(model: ParticipantsSelectorCardViewModel){
        self.isAccessibilityElement = true
        self.accessibilityTraits = .button
        self.accessibilityLabel =  "Selecionar \(model.title). Item \(model.currentIndex ?? 0) de \(model.totalCount ?? 0)"
    }
    
    private func setupView(){
        addSubviews([nameLabel, dividerView])
        addTarget(nil, action: #selector(handleParticipantsSelectorCardViewTap), for: .touchUpInside)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 48),
            
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}

extension ParticipantsSelectorCardView {
    
    @objc func handleParticipantsSelectorCardViewTap(){
        delegate?.handleParticipantsSelectorCardViewTap(name: nameLabel.text ?? "")
    }
}
