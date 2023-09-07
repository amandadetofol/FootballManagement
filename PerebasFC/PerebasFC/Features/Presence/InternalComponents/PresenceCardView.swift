//
//  PresenceCardView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/09/23.
//

import UIKit

final class PresenceCardView: UIControl {
    
    private lazy var participantName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.isAccessibilityElement = false
        
        return label
    }()
    
    private lazy var presenceSwitch: UISwitch = {
        let presenceSwitch = UISwitch()
        presenceSwitch.translatesAutoresizingMaskIntoConstraints = false
        presenceSwitch.isAccessibilityElement = false
        
        return presenceSwitch
    }()
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.isAccessibilityElement = false
        
        return view
    }()
    
    var wasPresent: Bool {
        get {
            return presenceSwitch.isOn
        }
    }
    
    init(){
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(with model: PresenceCardViewModel) {
        participantName.text = model.name
        presenceSwitch.isOn = model.wasPresent
        addTarget(nil, action: #selector(handleParticipantSwitchTap), for: .touchUpInside)
    }
    
    func updateAccessibility(with model: PresenceCardViewModel){
        self.isAccessibilityElement = true
        self.accessibilityTraits = .button
        self.accessibilityLabel = "\(model.name) Estava presente: \(model.wasPresent). Item \(model.currentIndex ?? 0) de \(model.total ?? 0). Clique para \(model.wasPresent ? "remover a presença" : "adicionar presença")"
    }
    
    private func setupView(){
        backgroundColor = .white
        addSubviews([
            participantName,
            presenceSwitch,
            view])
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 48),
            
            participantName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            participantName.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            presenceSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            presenceSwitch.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.heightAnchor.constraint(equalToConstant: 1),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}

extension PresenceCardView {
    
    @objc func handleParticipantSwitchTap(){
        presenceSwitch.isOn.toggle()
    }
    
}
