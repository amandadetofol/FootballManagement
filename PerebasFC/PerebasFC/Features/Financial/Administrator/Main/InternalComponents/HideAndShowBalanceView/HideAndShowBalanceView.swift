//
//  HideAndShowBalanceView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 14/08/23.
//

import UIKit

final class HideAndShowBalanceView: UIView {
    
    private var balance: String?
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var balanceValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var seeBalanceButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSeeBalanceButtonTap), for: .touchUpInside)
        
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
    
    func updateView(username: String, balance: String){
        userNameLabel.text = "Olá, \(username)!"
        balanceLabel.text = "Saldo: "
        balanceValueLabel.text = balance
        seeBalanceButton.setTitle("Ver saldo", for: .normal)
    }
    
    private func setupView(){
        addSubviews([
            userNameLabel,
            balanceLabel,
            balanceValueLabel,
            seeBalanceButton])
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            userNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            balanceLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 16),
            balanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            balanceValueLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 16),
            balanceValueLabel.leadingAnchor.constraint(equalTo: balanceLabel.leadingAnchor),
            
            seeBalanceButton.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 16),
            seeBalanceButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            seeBalanceButton.leadingAnchor.constraint(equalTo: balanceValueLabel.trailingAnchor)
        ])
    }
    
}

extension HideAndShowBalanceView {

    @objc func handleSeeBalanceButtonTap(){
        if balanceValueLabel.text?.contains("-") ?? false  {
            guard let balance = balance else { return }
            balanceValueLabel.text = balance
            seeBalanceButton.setTitle("Ocultar saldo", for: .normal)
        } else {
            balanceValueLabel.text = "--,--"
            seeBalanceButton.setTitle("Ver saldo", for: .normal)
        }
    }
    
}
