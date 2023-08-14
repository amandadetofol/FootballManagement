//
//  HomeHeaderView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 22/05/23.
//

import UIKit

protocol HomeHeaderViewDelegate: AnyObject {
    func handleLogout()
    func handleAccessibilityButtonTap()
}

final class HomeHeaderView: UIView {
    
    weak var delegate: HomeHeaderViewDelegate?
    
    private lazy var initialsView: UIControl = {
        let view = UIControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemYellow.withAlphaComponent(0.3)
        view.clipsToBounds = true
        view.layer.cornerRadius = 24
        view.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "ipad.and.arrow.forward"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.accessibilityLabel = "Sair do aplicativo."
        imageView.tintColor = .black
        
        return imageView
    }()
    
    private let accessibilityButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "figure.arms.open"), for: .normal)
        button.accessibilityLabel = "Abrir configuracoes de acessibilidade"
        button.tintColor = .systemBlue
        button.configuration = .filled()
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.addTarget(nil, action: #selector(handleAccessibilityButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        return label
    }()
    
    private lazy var fullName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16.0)
        
        return label
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
    
    func updateView(with model: HomeHeaderViewModel) {
        welcomeLabel.text = model.welcomeText
        fullName.text = model.fullName
    }
    
    private func setupView(){
        backgroundColor = .systemBackground
        self.addSubviews([
            welcomeLabel,
            initialsView,
            accessibilityButton,
            welcomeLabel,
            fullName])
        initialsView.addSubview(iconImageView)
    }

    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 86),
            
            iconImageView.centerYAnchor.constraint(equalTo: initialsView.centerYAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: initialsView.centerXAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            
            accessibilityButton.centerYAnchor.constraint(equalTo: initialsView.centerYAnchor),
            accessibilityButton.heightAnchor.constraint(equalToConstant: 48),
            accessibilityButton.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: -16),
            accessibilityButton.widthAnchor.constraint(equalToConstant: 48),
            
            initialsView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            initialsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            initialsView.heightAnchor.constraint(equalToConstant: 48),
            initialsView.widthAnchor.constraint(equalToConstant: 48),
 
            welcomeLabel.topAnchor.constraint(equalTo: topAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            welcomeLabel.trailingAnchor.constraint(equalTo: initialsView.leadingAnchor, constant: -16),
            
            fullName.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor),
            fullName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            fullName.trailingAnchor.constraint(equalTo: initialsView.leadingAnchor, constant: -16),
            fullName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
}

extension HomeHeaderView {
    
    @objc func logout(){
        delegate?.handleLogout()
    }
    
    @objc func handleAccessibilityButtonTap(){
        delegate?.handleAccessibilityButtonTap()
    }
    
}
