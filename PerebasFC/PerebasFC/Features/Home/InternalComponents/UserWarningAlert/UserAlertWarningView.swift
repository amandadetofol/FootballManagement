//
//  UserAlertWarningView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 23/05/23.
//

import UIKit

protocol UserAlertWarningViewDelegate: AnyObject {
    func handleCloseButtonTap()
    func handleActionButtonTap(key: InternalLinkRedirectKeys)
}

final class UserAlertWarningView: UIControl {
    
    weak var delegate: UserAlertWarningViewDelegate?
    
    var key: InternalLinkRedirectKeys?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.isAccessibilityElement = false
        
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black 
        button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        button.isAccessibilityElement = false
        
        return button
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isAccessibilityElement = false
        imageView.tintColor = .systemYellow.withAlphaComponent(0.5)
        
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.isAccessibilityElement = false
        
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleActionButtonTap), for: .touchUpInside)
        button.isAccessibilityElement = false
        
        return button
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
    
    func updateView(withModel: UserAlertWarningViewModel) {
        titleLabel.text = withModel.warning.title
        iconImageView.image = withModel.icon
        descriptionLabel.text = withModel.warning.description
        key = withModel.warning.firstActionKey
        actionButton.setTitle(withModel.warning.firstActionTitle, for: .normal)
        setupAccessibility(model: withModel)
        
        if UIAccessibility.isVoiceOverRunning {
            addTarget(nil, action: #selector(handleActionButtonTap), for: .touchUpInside)
        }
    }
    
    private func setupAccessibility(model: UserAlertWarningViewModel){
        self.isAccessibilityElement = true
        self.accessibilityTraits = .button
        self.accessibilityLabel = model.warning.description
    }
    
    private func setupView(){
        addSubviews([
            titleLabel,
            closeButton,
            iconImageView,
            descriptionLabel,
            actionButton])
        setupBorders()
    }
    
    private func setupBorders(){
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 300),
            
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            actionButton.heightAnchor.constraint(equalToConstant: 48),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -16),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            iconImageView.heightAnchor.constraint(equalToConstant: 48),
            iconImageView.widthAnchor.constraint(equalToConstant: 48),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -16),
            
            titleLabel.bottomAnchor.constraint(equalTo: iconImageView.topAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -16),
            
            closeButton.bottomAnchor.constraint(equalTo: iconImageView.topAnchor, constant: -16),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
    
}

extension UserAlertWarningView {
    
    @objc func didTapCloseButton(){
        UIView.animate(withDuration: 0.75) {
            self.isHidden = true
        }
        
        delegate?.handleCloseButtonTap()
    }
    
    @objc func handleActionButtonTap(){
        guard let key = self.key else { return }
        delegate?.handleActionButtonTap(key: key)
    }
    
}
