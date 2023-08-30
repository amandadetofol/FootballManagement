//
//  BarAndThrophyView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 01/06/23.
//

import UIKit

final class BarAndThrophyView: UIView {
    
    private lazy var initialsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .black
        label.layer.cornerRadius = 12
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.clipsToBounds = true
        label.layer.cornerRadius = 16
        
        return label
    }()
    
    private lazy var throphyIconImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "trophy"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.isAccessibilityElement = false
        
        return image
    }()
    
    private lazy var barView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var barLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        return label
    }()
    
    private var position = 0 {
        didSet {
            if position > 0 {
                barView.heightAnchor.constraint(equalToConstant: CGFloat(148/getBarHeight())).isActive = true
            }
        }
    }
    
    init(){
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(with model: BarAndTrophyViewModel){
        initialsLabel.text = model.initials
        throphyIconImageView.tintColor = model.trophyColor
        barView.backgroundColor = model.barColor
        barLabel.text = "\(Int(model.postiionLabel))°"
        position = model.postiionLabel
    }
    
    func updateAccessibility(with model: BarAndTrophyViewModel) {
        self.isAccessibilityElement = true
        self.accessibilityTraits = .staticText
        self.accessibilityLabel =  "O jogador: " + model.initials + "Esta na posição: " + String(model.postiionLabel)
    }
    
    private func setupView(){
        addSubviews([
            initialsLabel,
            throphyIconImageView,
            barView,
            barLabel])
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            barView.widthAnchor.constraint(equalToConstant: 48),
            barView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            barLabel.topAnchor.constraint(equalTo: barView.bottomAnchor, constant: 4),
            barLabel.leadingAnchor.constraint(equalTo: barView.leadingAnchor),
            barLabel.trailingAnchor.constraint(equalTo: barView.trailingAnchor),
           
            throphyIconImageView.heightAnchor.constraint(equalToConstant: 24),
            throphyIconImageView.widthAnchor.constraint(equalToConstant: 24),
            throphyIconImageView.centerXAnchor.constraint(equalTo: barView.centerXAnchor),
            throphyIconImageView.bottomAnchor.constraint(equalTo: barView.topAnchor, constant: -4),
            
            initialsLabel.bottomAnchor.constraint(equalTo: throphyIconImageView.topAnchor, constant: -2),
            initialsLabel.heightAnchor.constraint(equalToConstant: 32),
            initialsLabel.widthAnchor.constraint(equalToConstant: 32),
            initialsLabel.centerXAnchor.constraint(equalTo: throphyIconImageView.centerXAnchor),
            
        ])
    }
        
    private func getBarHeight() -> Double {
        switch position {
            case 1: return 1.5
            case 2: return 2
            case 3: return 2.5
            default: return 0
        }
    }
    
}
