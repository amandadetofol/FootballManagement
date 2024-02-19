//
//  SortCardView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/08/23.
//

import UIKit

protocol SortCardViewDelegate: AnyObject {
    func handleCardViewDelegateTap(model: WeekTeamViewModel)
}

final class SortCardView: UIControl {
    
    weak var delegate: SortCardViewDelegate?
    var model: WeekTeamViewModel?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.isUserInteractionEnabled = false
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.isUserInteractionEnabled = false
        
        return label
    }()
    
    private lazy var arrowIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.forward"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = .black
        imageView.isUserInteractionEnabled = false
        
        return imageView
    }()
    
    init(model: SortCardViewModel){
        super.init(frame: .zero)
        setupView()
        setupConstraints()
        setupBorders()
        setupView(with: model)
        addTarget(self, action: #selector(handleCardViewDelegateTap), for: .touchUpInside)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(with model: SortCardViewModel){
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        self.model = model.model
        backgroundColor = Session.shared.highLightColor.withAlphaComponent(0.10)
        updateAcessibility(model: model)
    }
    
    private func updateAcessibility(model: SortCardViewModel){
        self.isAccessibilityElement = true
        self.accessibilityTraits = .button
        self.accessibilityLabel = model.title + model.description + "\(model.currentIndex) de \(model.total). Ver detalhes do Sorteio."
    }
    
    private func setupView(){
        addSubviews([
            titleLabel,
            descriptionLabel,
            arrowIconImageView])
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 96),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            arrowIconImageView.heightAnchor.constraint(equalToConstant: 16),
            arrowIconImageView.widthAnchor.constraint(equalToConstant: 16),
            arrowIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            arrowIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupBorders(){
        layer.cornerRadius = 10
        layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 1
    }
    
}

extension SortCardView {
    
    @objc func handleCardViewDelegateTap(){
        guard let model = model else { return }
        delegate?.handleCardViewDelegateTap(model: model)
    }
    
}
