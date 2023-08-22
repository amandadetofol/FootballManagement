//
//  FinancialAdministratorHistoryListView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 21/08/23.
//

import UIKit
 
final class FinancialAdministratorHistoryListView: UIView {
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        
        return stackView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var borderedContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        stackView.clipsToBounds = true
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = 15
        
        return stackView
    }()
    
    private lazy var nameNameAndValueView: NameAndValueView = {
        let nameAndValueView = NameAndValueView()
        nameAndValueView.translatesAutoresizingMaskIntoConstraints = false
        
        return nameAndValueView
    }()
    
    private lazy var valueNameAndValueView: NameAndValueView = {
        let nameAndValueView = NameAndValueView()
        nameAndValueView.translatesAutoresizingMaskIntoConstraints = false
        
        return nameAndValueView
    }()
    
    private lazy var operationTypeNameAndValueView: NameAndValueView = {
        let nameAndValueView = NameAndValueView()
        nameAndValueView.translatesAutoresizingMaskIntoConstraints = false
        
        return nameAndValueView
    }()
    
    init(){
        super.init(frame: .zero)
        setupView()
        setupConstraints()
        backgroundColor = .white
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(with model: FinancialAdministratorHistoryViewModel){
        dateLabel.text = "Data: \(model.date)"
        balanceLabel.text = "Saldo: \(model.dayBalance)"
        nameNameAndValueView.updateView(name: "Nome:", value: model.name)
        valueNameAndValueView.updateView(name: "Valor:", value: model.operationValue)
        operationTypeNameAndValueView.updateView(name: "Tipo de Operação:", value: model.operatioType.description)
    }
    
    private func setupView(){
        addSubview(contentStackView)
        contentStackView.addArrangedSubviews([dateLabel, balanceLabel, borderedContentStackView])
        borderedContentStackView.addArrangedSubviews([
            nameNameAndValueView,
            valueNameAndValueView,
            operationTypeNameAndValueView
        ])
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            
            balanceLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            balanceLabel.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.widthAnchor.constraint(equalTo: widthAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}


