//
//  ParticipantCellView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 08/08/23.
//

import UIKit

protocol ParticipantCellViewDelegate: AnyObject {
    func handleParticipantCardViewTap(user: User)
}

final class PariticipantCellView: UIControl {
    
    weak var delegate: ParticipantCellViewDelegate?
    private var user: User?
    
    private lazy var playerIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.crop.square.filled.and.at.rectangle.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isAccessibilityElement = false
        imageView.isUserInteractionEnabled = false
        imageView.tintColor = .brown
        
        return imageView
    }()
    
    private lazy var arrowIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isAccessibilityElement = false
        imageView.isUserInteractionEnabled = false
        imageView.tintColor = .brown
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.isUserInteractionEnabled = false
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.isUserInteractionEnabled = false
        
        return label
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
    
    func updateView(with model: ParticipantCellModel){
        titleLabel.text = model.name
        descriptionLabel.text = model.position
        user = model.user
        addTarget(nil, action: #selector(handleParticipantCardViewTap), for: .touchUpInside)
    }
    
    func updateAccessibility(with model: ParticipantCellModel){
        self.isAccessibilityElement = true
        self.accessibilityTraits = .button
        self.accessibilityLabel = model.name + model.position + "\(model.currentIndex ?? 0) de \(model.total ?? 0)" + "Ver detalhes"
    }
    
    private func setupView(){
        addSubviews([
            arrowIconImageView,
            playerIconImageView,
            titleLabel,
            descriptionLabel])
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            heightAnchor.constraint(equalToConstant: 76),
            
            playerIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            playerIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            playerIconImageView.heightAnchor.constraint(equalToConstant: 36),
            playerIconImageView.widthAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: playerIconImageView.trailingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: playerIconImageView.trailingAnchor, constant: 16),
        
            arrowIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            arrowIconImageView.heightAnchor.constraint(equalToConstant: 16),
            arrowIconImageView.heightAnchor.constraint(equalToConstant: 16),
        ])
    }
    
    private func setupBorders(){
        layer.cornerRadius = 10
        layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 1
    }
    
}

extension PariticipantCellView {
    
    @objc func handleParticipantCardViewTap(){
        guard let user = user else { return }
        delegate?.handleParticipantCardViewTap(user: user)
    }
    
}
