//
//  WelcomeView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 15/05/23.
//

import UIKit

protocol WelcomeViewDelegate: AnyObject {
    func goToLogin()
    func goToNewTeam()
}

final class WelcomeView: UIView {
    
    weak var delegate: WelcomeViewDelegate?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName:"sportscourt.circle.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.isAccessibilityElement = false 
        
        return imageView
    }()
    
    private lazy var benefitLabelDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20.0)
        
        return label
    }()
    
    private lazy var signUpWithNewTeamButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Cadastrar uma nova patota", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(goToNewTeam), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var startUsingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Entrar", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
        
        return button
    }()
    
    init(){
        super.init(frame: .zero)
        benefitLabelDescription.text = "Caso já possua uma patota cadastrada, clique em Entrar. \n\nCaso contrário cadastre sua patota em Cadastrar nova patota."
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(imageView)
        addSubview(benefitLabelDescription)
        addSubview(startUsingButton)
        addSubview(signUpWithNewTeamButton)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 48),
            imageView.heightAnchor.constraint(equalToConstant: 128),
            imageView.widthAnchor.constraint(equalToConstant: 128),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            benefitLabelDescription.centerXAnchor.constraint(equalTo: centerXAnchor),
            benefitLabelDescription.centerYAnchor.constraint(equalTo: centerYAnchor),
            benefitLabelDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            benefitLabelDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            signUpWithNewTeamButton.heightAnchor.constraint(equalToConstant: 48),
            signUpWithNewTeamButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            signUpWithNewTeamButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            signUpWithNewTeamButton.bottomAnchor.constraint(equalTo: startUsingButton.topAnchor, constant: -16),
            
            startUsingButton.heightAnchor.constraint(equalToConstant: 48),
            startUsingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            startUsingButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            startUsingButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -64),
        ])
    }
    
    //MARK: Button action
    @objc func goToLogin(){
        delegate?.goToLogin()
    }
    
    @objc func goToNewTeam(){
        delegate?.goToNewTeam()
    }
}
