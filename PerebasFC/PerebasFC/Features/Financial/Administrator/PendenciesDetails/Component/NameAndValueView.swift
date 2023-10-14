//
//  NameAndValueView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 20/08/23.
//

import UIKit

final class NameAndValueView: UIView {
    
    private lazy var nameBoldLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var valueLabel: TextFieldComponent = {
        let label = TextFieldComponent()
        label.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    func updateView(name: String, value: String){
        nameBoldLabel.text = name
        valueLabel.text = value
    }
    
    private func setupView(){
        addSubviews([nameBoldLabel, valueLabel])
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 32),
            
            nameBoldLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameBoldLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            valueLabel.leadingAnchor.constraint(equalTo: nameBoldLabel.trailingAnchor, constant: 4),
        ])
    }
}
