//
//  CurrentTeamCardView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 25/05/23.
//

import UIKit

final class CurrentTeamCardView: UIView {
    
    private lazy var teamLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        return label
    }()
    
    private lazy var shirtNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20.0)
        
        return label
    }()
    
    private lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20.0)
        
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
    
    func updateView(with model: HomeTeamInfo){
        teamLabel.text = "Time da Semana: " + model.teamName
        positionLabel.text =  "Posição: " + model.position
        shirtNumberLabel.text = "Número da camisa: " + model.shirtNumber
    }
    
    private func setupView(){
        addSubviews([teamLabel, positionLabel, shirtNumberLabel])
        clipsToBounds = true
        layer.cornerRadius = 20
        backgroundColor = .white
        layer.borderWidth = 1
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 108),
            
            teamLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            teamLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            teamLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        
            positionLabel.topAnchor.constraint(equalTo: teamLabel.bottomAnchor, constant: 4),
            positionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            positionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            shirtNumberLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 4),
            shirtNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            shirtNumberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
}