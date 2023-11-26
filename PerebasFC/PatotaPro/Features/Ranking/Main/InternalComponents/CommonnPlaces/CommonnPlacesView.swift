//
//  CommonnPlacesView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 01/06/23.
//

import UIKit

final class CommonnPlacesView: UIView {
    
    private lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.isAccessibilityElement = false
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.isAccessibilityElement = false
        label.font = UIFont.systemFont(ofSize: 20.0)
        
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "arrow.up"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.isAccessibilityElement = false
        image.tintColor = .green
        
        return image
    }()
    
    init(){
        super.init(frame: .zero)
        setupView()
        setupConstraints()
        setupBorders()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(with model: CommonnPlacesViewModel) {
        positionLabel.text = String(model.postion)
        nameLabel.text = model.name
        arrowImageView.isHidden = !model.wentUp
        updateAccessibility(with: model)
    }
    
    private func updateAccessibility(with model: CommonnPlacesViewModel) {
        self.isAccessibilityElement = true
        self.accessibilityTraits = .staticText
        self.accessibilityLabel = "O jogador: \(model.name) esta na posição \(model.postion). \(model.wentUp ? "Subiu na colocação" : "")"
    }
    
    private func setupView(){
        addSubviews(
            [positionLabel,
             nameLabel,
             arrowImageView])
        backgroundColor = .white
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 48),
            
            positionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            positionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: positionLabel.trailingAnchor, constant: 32),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            arrowImageView.heightAnchor.constraint(equalToConstant: 16),
            arrowImageView.widthAnchor.constraint(equalToConstant: 16),
            arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func setupBorders(){
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 1
    }
    
}
