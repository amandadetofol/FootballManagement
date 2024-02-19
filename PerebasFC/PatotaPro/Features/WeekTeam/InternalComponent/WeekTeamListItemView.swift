//
//  WeekTeamListItemView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 29/05/23.
//

import UIKit

final class WeekTeamListItemView: UIView {
    
    private lazy var shirtNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.isAccessibilityElement = false
        
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.isAccessibilityElement = false
        
        return label
    }()
    
    private lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.isAccessibilityElement = false
        
        return label
    }()
    
    private lazy var rankingStatusIcon: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "trophy.fill"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.isAccessibilityElement = false
        
        return image
    }()
    
    private lazy var rankingStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.isAccessibilityElement = false 
        
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
    
    func setupCard(with model: WeekTeamListViewModel){
        shirtNumber.text = String(model.shirtNumber)
        nameLabel.text = model.fullName
        positionLabel.text = model.position
        rankingStatusLabel.text = String(model.rankingPosition)
        
        if model.rankingPosition == 1 {
            rankingStatusIcon.tintColor = UIColor(red: 218/255, green: 162/255, blue: 32/255, alpha: 1.0)
        } else if model.rankingPosition >= 2 && model.rankingPosition <= 11 {
            rankingStatusIcon.tintColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1.0)
        } else {
            rankingStatusIcon.tintColor = UIColor(red: 148/255, green: 193/255, blue: 65/255, alpha: 1.0)
        }
    }
    
    func updateAccessibility(model: WeekTeamListViewModel) {
        self.isAccessibilityElement = true
        self.accessibilityTraits = .button
        self.accessibilityLabel = model.fullName + model.position + "camisa: \(model.shirtNumber)" + "posição \(model.rankingPosition) no ranking \(model.currentIndex ?? 0) de \(model.total ?? 0)"
    }
    
    private func setupView(){
        addSubviews([
            shirtNumber,
            nameLabel,
            positionLabel,
            rankingStatusIcon,
            rankingStatusLabel])
        setupBorders()
    }
    
    private func setupBorders(){
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 1
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 48),
            
            shirtNumber.centerYAnchor.constraint(equalTo: centerYAnchor),
            shirtNumber.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            nameLabel.leadingAnchor.constraint(equalTo: shirtNumber.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            
            positionLabel.leadingAnchor.constraint(equalTo: shirtNumber.trailingAnchor, constant: 16),
            positionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            
            rankingStatusIcon.heightAnchor.constraint(equalToConstant: 24),
            rankingStatusIcon.widthAnchor.constraint(equalToConstant: 24),
            rankingStatusIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            rankingStatusIcon.topAnchor.constraint(equalTo: topAnchor, constant: 8),

            rankingStatusLabel.topAnchor.constraint(equalTo: rankingStatusIcon.bottomAnchor, constant: -4),
            rankingStatusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func setupAccessbility(using model: WeekTeamListViewModel){
        self.isAccessibilityElement = true
        self.accessibilityLabel = "\(model.fullName) \(model.position) \(String(describing: model.currentIndex)) de \(String(describing: model.total))"
    }
}
