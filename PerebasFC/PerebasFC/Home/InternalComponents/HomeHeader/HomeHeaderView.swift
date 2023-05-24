//
//  HomeHeaderView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 22/05/23.
//

import UIKit

final class HomeHeaderView: UIView {
    
    private lazy var initialsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed.withAlphaComponent(0.8)
        view.clipsToBounds = true
        view.layer.cornerRadius = 24
        
        return view
    }()
    
    private lazy var initialsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .systemBackground
        
        return label
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
        initialsLabel.text = model.initials
        welcomeLabel.text = model.welcomeText
        fullName.text = model.fullName
    }
    
    private func setupView(){
        backgroundColor = .systemBackground
        self.addSubviews([
            welcomeLabel,
            initialsView,
            welcomeLabel,
            fullName])
        initialsView.addSubview(initialsLabel)
    }

    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 86),
            
            initialsLabel.centerXAnchor.constraint(equalTo: initialsView.centerXAnchor),
            initialsLabel.centerYAnchor.constraint(equalTo: initialsView.centerYAnchor),
            
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
