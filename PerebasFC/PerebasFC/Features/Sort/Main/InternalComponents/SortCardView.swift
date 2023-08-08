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
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        return label
    }()
    
    private lazy var arrowIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.forward"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = .black
        
        return imageView
    }()
    
    init(model: SortCardViewModel){
        super.init(frame: .zero)
        setupView()
        setupConstraints()
        setupBorders()
        setupView(with: model)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(with model: SortCardViewModel){
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        self.model = model.model
        backgroundColor = .brown.withAlphaComponent(0.10)
    }
    
    private func setupView(){
        addSubviews([
            titleLabel,
            descriptionLabel,
            arrowIconImageView])
        addTarget(self, action: #selector(handleCardViewDelegateTap), for: .touchUpInside)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 72),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
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
