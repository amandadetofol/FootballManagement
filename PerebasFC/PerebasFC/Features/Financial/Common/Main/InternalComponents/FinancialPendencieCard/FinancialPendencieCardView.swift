//
//  FinancialPendencieCardView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 12/06/23.
//

import UIKit

protocol FinancialPendencieCardViewDelegate: AnyObject {
    func handleFinancialPendencieCardTap(model: FinancialPendencieCardViewModel)
}

final class FinancialPendencieCardView: UIControl {
    
    weak var delegate: FinancialPendencieCardViewDelegate?
    var model: FinancialPendencieCardViewModel?
    
    private lazy var dollarSignImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "dollarsign.circle.fill"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .systemBlue
        
        return label
    }()
    
    private lazy var reasonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .darkGray
        
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "arrow.right"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.tintColor = .black
        
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
    
    func updateView(with model: FinancialPendencieCardViewModel){
        dollarSignImageView.tintColor = !model.admAprooved ? .systemRed : .systemGreen
        titleLabel.text = model.title
        descriptionLabel.text = model.actionLabel
        reasonLabel.text = model.reason
        if model.isLate {
            descriptionLabel.text = "Anexar comprovante"
        }
        self.model = model
    }
    
    func updateAccessibility(model: FinancialPendencieCardViewModel) {
        isAccessibilityElement = true
        accessibilityTraits = .button
        accessibilityLabel = "\(model.title) \((model.admAprooved ? "\(model.reason). Realize o pagamento e anexe o comprovante." : "Conta em dia!")). Item \(model.currentIndex ?? 0) de \(model.total ?? 0) \(model.actionLabel)"
    }
    
    private func setupBorders(){
        layer.cornerRadius = 10
        layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 1
    }
    
    private func setupView(){
        addSubviews([
            dollarSignImageView,
            titleLabel,
            descriptionLabel,
            reasonLabel,
            arrowImageView])
        addTarget(self, action: #selector(handleFinancialPendencieCardTap), for: .touchUpInside)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 92),
            
            dollarSignImageView.heightAnchor.constraint(equalToConstant: 24),
            dollarSignImageView.widthAnchor.constraint(equalToConstant: 24),
            dollarSignImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            dollarSignImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: dollarSignImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: dollarSignImageView.trailingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -16),
            
            reasonLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            reasonLabel.leadingAnchor.constraint(equalTo: dollarSignImageView.trailingAnchor, constant: 16),
            reasonLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -16),
            
            arrowImageView.heightAnchor.constraint(equalToConstant: 16),
            arrowImageView.widthAnchor.constraint(equalToConstant: 16),
            arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
}

extension FinancialPendencieCardView {
    
    @objc func handleFinancialPendencieCardTap(){
        guard let model = model else { return }
        delegate?.handleFinancialPendencieCardTap(model: model)
    }
    
}
