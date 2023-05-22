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
        view.backgroundColor = .systemRed.withAlphaComponent(0.5)
        view.clipsToBounds = true
        view.addSubview(initialsLabel)
        
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
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24.0)
        
        return label
    }()
    
    private lazy var fullName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24.0)
        
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
        self.addSubviews([initialsView, welcomeLabel, fullName])
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            initialsLabel.centerXAnchor.constraint(equalTo: initialsView.centerXAnchor),
            initialsLabel.centerYAnchor.constraint(equalTo: initialsView.centerYAnchor),
            
            initialsView.centerYAnchor.constraint(equalTo: centerYAnchor),
            initialsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            initialsView.heightAnchor.constraint(equalToConstant: 32),
            initialsView.widthAnchor.constraint(equalToConstant: 32),
            
            welcomeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            welcomeLabel.trailingAnchor.constraint(equalTo: initialsView.leadingAnchor, constant: -32),
            
            fullName.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 16),
            fullName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            fullName.trailingAnchor.constraint(equalTo: initialsView.leadingAnchor, constant: -32),
            fullName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
        ])
    }
}
