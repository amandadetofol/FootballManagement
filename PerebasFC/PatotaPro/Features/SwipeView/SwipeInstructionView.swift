//
//  SwipeInstructionView.swift
//  PatotaPro
//
//  Created by Amanda Detofol on 19/02/24.
//

import UIKit

final class SwipeInstructionView: UIView {
    
    private lazy var swipeImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "swipe"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    private lazy var informationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "Deslize o dedo sobre o card para acessar os detalhes:"
        label.font = UIFont.systemFont(ofSize: 14)
       
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
    
    private func setupView(){
        backgroundColor = UIColor.white
        addSubviews([informationLabel, swipeImageView])
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            informationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            informationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            informationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            swipeImageView.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 32),
            swipeImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            swipeImageView.widthAnchor.constraint(equalToConstant: 150),
            swipeImageView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
}
