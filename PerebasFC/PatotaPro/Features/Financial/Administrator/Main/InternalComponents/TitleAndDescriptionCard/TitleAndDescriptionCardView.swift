//
//  TitleAndDescriptionCardView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 14/08/23.
//

import UIKit

protocol TitleAndDescriptionCardViewDelegate: AnyObject {
    func handleTitleAndDescriptionCardViewTap(model: FinancialAdministratorActions)
}

final class TitleAndDescriptionCardView: UIControl {
    
    weak var delegate: TitleAndDescriptionCardViewDelegate?
    private var model: FinancialAdministratorActions?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
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
        image.tintColor = Session.shared.highLightColor
        
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
    
    func updateView(model: FinancialAdministratorActions){
        self.titleLabel.text = model.rawValue
        self.descriptionLabel.text = model.description
        self.model = model
        addTarget(self, action: #selector(handleTitleAndArrowButtonTap), for: .touchUpInside)
    }
    
    func updateAccessibility(
        model: FinancialAdministratorActions,
        currentIndex: Int?,
        total: Int?){
            self.isAccessibilityElement = true
            self.accessibilityTraits = .button
            self.accessibilityLabel = "\(model.rawValue). \(model.description). Ver detalhes. Item \(currentIndex ?? 0) de \(total ?? 0) "
        }
    
    private func setupView(){
        addSubviews([
            titleLabel,
            descriptionLabel,
            arrowImageView])
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 86),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
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

extension TitleAndDescriptionCardView {
    
    @objc func handleTitleAndArrowButtonTap(){
        guard let model = model else { return }
        delegate?.handleTitleAndDescriptionCardViewTap(model: model)
    }
    
}
