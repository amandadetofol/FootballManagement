//
//  EventPresenceCardView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/09/23.
//

import UIKit

final class EventPresenceCardView: UIView {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var numberOfCompanyDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Número de acompanhantes: "
        
        return label
    }()
    
    private lazy var numberOfCompanyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)

        return label
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isAccessibilityElement = false
        view.backgroundColor = .gray
        
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
    
    func setupView(with model: EventPresenceCardViewModel){
        nameLabel.text = model.name
        numberOfCompanyLabel.text = String(model.companieNumber ?? 0)
    }
    
    func setupAccessibility(with model: EventPresenceCardViewModel){
        self.isAccessibilityElement = true
        self.accessibilityTraits = .staticText
        self.accessibilityLabel = "\(model.name). Número de acompanhantes\(model.companieNumber ?? 0). Item \(model.currentIndex ?? 0) de \(model.total ?? 0)."
    }
    
    private func setupView(){
        addSubviews([
            nameLabel,
            numberOfCompanyDescriptionLabel,
            numberOfCompanyLabel,
            dividerView])
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 72),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            numberOfCompanyDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            numberOfCompanyDescriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            
            numberOfCompanyLabel.leadingAnchor.constraint(equalTo: numberOfCompanyDescriptionLabel.trailingAnchor, constant: 4),
            numberOfCompanyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            numberOfCompanyLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
}
