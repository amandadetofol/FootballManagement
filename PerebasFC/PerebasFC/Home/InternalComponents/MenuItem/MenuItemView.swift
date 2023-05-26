//
//  MenuItemView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 24/05/23.
//

import UIKit

protocol MenuItemViewDelegate: AnyObject {
    func handleMenuItemViewTap(basedOn key: InternalLinkRedirectKeys)
}

final class MenuItemView: UIControl {
    
    weak var delegate: MenuItemViewDelegate?
    var key: InternalLinkRedirectKeys?
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isAccessibilityElement = false
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.isAccessibilityElement = false
        
        return label
    }()
    
    private lazy var arrowView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.forward"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .black
        imageView.isAccessibilityElement = false 
        
        return imageView
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
    
    func updateView(with model: MenuItemViewModel){
        iconImageView.image = model.icon
        key = model.redirectKey
        titleLabel.text = model.title
        
        setupAccessibility(title: model.title)
    }
    
    private func setupView(){
        addSubviews([titleLabel, iconImageView, arrowView])
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 58),
            
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: -16),
            titleLabel.trailingAnchor.constraint(equalTo: arrowView.leadingAnchor, constant: 16),
            
            arrowView.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            arrowView.heightAnchor.constraint(equalToConstant: 16),
            arrowView.widthAnchor.constraint(equalToConstant: 16),
        ])
    }
    
    private func setupBorders(){
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 1
    }
    
    private func setupAccessibility(title: String) {
        isAccessibilityElement = true
        accessibilityTraits = .button
        accessibilityLabel = title + "Ver detalhes."
    }
}
