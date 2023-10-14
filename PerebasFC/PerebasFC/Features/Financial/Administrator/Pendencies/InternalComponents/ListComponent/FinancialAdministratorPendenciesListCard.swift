//
//  FinancialAdministratorPendenciesListCard.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 19/08/23.
//

import UIKit

protocol FinancialAdministratorPendenciesListCardDelegate: AnyObject {
    func handleTitleAndDescriptionCardViewTap(model: FinancialAdministratorPendenciesListCardModel)
}

final class FinancialAdministratorPendenciesListCard: UIControl {
    
    weak var delegate: FinancialAdministratorPendenciesListCardDelegate?
    private var model: FinancialAdministratorPendenciesListCardModel?
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "arrow.right"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.tintColor = .gold
        
        return image
    }()
    
    init(){
        super.init(frame: .zero)
        setupView()
        setupBorders()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(model: FinancialAdministratorPendenciesListCardModel){
        self.titleLabel.text = model.name
        self.valueLabel.text = "Valor: R$\(model.value)"
        self.descriptionLabel.text = "Motivo: \(model.name)"
        self.userNameLabel.text = "Usuário: \(model.userName)"
        self.model = model
    }
    
    func updateAccessibility(model: FinancialAdministratorPendenciesListCardModel){
        self.isAccessibilityElement = true
        self.accessibilityTraits = .button
        self.accessibilityLabel = "\(model.title). \(model.name) Valor: \(model.value). Item \(model.currentIndex ?? 0) de \(model.total ?? 0). Ver detalhes."
    }
    
    private func setupView(){
        addSubviews([
            userNameLabel,
            titleLabel,
            descriptionLabel,
            valueLabel,
            arrowImageView])
        addTarget(nil, action: #selector(handleTitleAndArrowButtonTap), for: .touchUpInside)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 144),
            
            userNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            userNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            titleLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        
            descriptionLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowImageView.heightAnchor.constraint(equalToConstant: 16),
            arrowImageView.widthAnchor.constraint(equalToConstant: 16),
            arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func setupBorders(){
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        clipsToBounds = true
        layer.cornerRadius = 15
    }
    
}

extension FinancialAdministratorPendenciesListCard {
    
    @objc func handleTitleAndArrowButtonTap(){
        guard let model = model else { return }
        delegate?.handleTitleAndDescriptionCardViewTap(model: model)
    }
    
}
