//
//  AministratorPendenciesDetailsView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 19/08/23.
//

import UIKit

protocol AdministratorPendenciesDetailsViewDelegate: AnyObject {
    func handleConfirmButtonTap(url: String?)
    func handleSendNotificationButtonTap(model: FinancialAdministratorPendenciesListCardModel)
    func handleSaveButton(model: FinancialAdministratorPendenciesListCardModel)
    func handleAprooveButton(model: FinancialAdministratorPendenciesListCardModel)
}

final class AdministratorPendenciesDetailsView: UIView {
    
    weak var delegate: AdministratorPendenciesDetailsViewDelegate?
    private var url: String?
    private var id: String = ""
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isAccessibilityElement = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isAccessibilityElement = false
        scrollView.backgroundColor = .clear
        
        return scrollView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.layoutMargins = UIEdgeInsets(
            top: 16,
            left: 16,
            bottom: 16,
            right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        
        return stackView
    }()

    private lazy var nameValues: TextFieldComponent = {
        let nameValues = TextFieldComponent()
        nameValues.title = "Nome"
        nameValues.translatesAutoresizingMaskIntoConstraints = false
        
        return nameValues
    }()
    
    private lazy var valueValues: TextFieldComponent = {
        let nameValues = TextFieldComponent()
        nameValues.title = "Valor"
        nameValues.translatesAutoresizingMaskIntoConstraints = false
        
        return nameValues
    }()
    
    private lazy var descriptionValues: TextFieldComponent = {
        let nameValues = TextFieldComponent()
        nameValues.title = "Descrição"
        nameValues.translatesAutoresizingMaskIntoConstraints = false
        
        return nameValues
    }()
    
    private lazy var daysLateValues: TextFieldComponent = {
        let nameValues = TextFieldComponent()
        nameValues.title = "Número de dias em atraso"
        nameValues.translatesAutoresizingMaskIntoConstraints = false
        
        return nameValues
    }()
    
    private lazy var userNameValues: TextFieldComponent = {
        let nameValues = TextFieldComponent()
        nameValues.title = "E-mail"
        nameValues.translatesAutoresizingMaskIntoConstraints = false
        
        return nameValues
    }()
    
    private lazy var confirmActionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Ver comprovante".uppercased(), for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleConfirmButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var sendNotificationActionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.setTitle("Enviar e-mail".uppercased(), for: .normal)
        button.addTarget(self, action: #selector(handleSendNotificationButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var saveItemButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.setTitle("salvar".uppercased(), for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleSaveButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var aprooveItemButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.setTitle("aprovar item".uppercased(), for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleAprooveButton), for: .touchUpInside)
        
        return button
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
    
    func updateView(with model: FinancialAdministratorPendenciesListCardModel) {
        nameValues.text = model.name
        valueValues.text = model.value
        descriptionValues.text = model.title
        daysLateValues.text = String(model.daysLate)
        userNameValues.text = model.userName
        
        self.url = model.proofUrl
        self.id = model.id ?? ""   
        
        
        confirmActionButton.isHidden = model.proofUrl?.isEmpty ?? false
        sendNotificationActionButton.isHidden = !(model.proofUrl?.isEmpty ?? false )
        aprooveItemButton.isHidden = (model.proofUrl?.isEmpty ?? false )
    }
    
    private func setupView(){
        addSubview(contentView)
        contentView.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubviews([
            nameValues,
            valueValues,
            descriptionValues,
            daysLateValues,
            userNameValues,
            confirmActionButton,
            sendNotificationActionButton,
            saveItemButton,
            aprooveItemButton,
        ])
        contentStackView.setCustomSpacing(16, after: userNameValues)
        contentStackView.setCustomSpacing(16, after: confirmActionButton)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            confirmActionButton.heightAnchor.constraint(equalToConstant: 48),
            confirmActionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            confirmActionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            sendNotificationActionButton.heightAnchor.constraint(equalToConstant: 48),
            sendNotificationActionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sendNotificationActionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            saveItemButton.heightAnchor.constraint(equalToConstant: 48),
            saveItemButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            saveItemButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            aprooveItemButton.heightAnchor.constraint(equalToConstant: 48),
            aprooveItemButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            aprooveItemButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
}

extension AdministratorPendenciesDetailsView {
    
    @objc func handleConfirmButtonTap(){
        guard let url = url else { return }
        delegate?.handleConfirmButtonTap(url: url)
    }
    
    @objc func handleSendNotificationButtonTap(){
        delegate?.handleSendNotificationButtonTap(model: FinancialAdministratorPendenciesListCardModel(
            title: nameValues.text,
            value: valueValues.text,
            name: descriptionValues.text,
            daysLate: Int(daysLateValues.text) ?? 0,
            proofUrl: url,
            userName: userNameValues.text,
            id: id))
    }
    
    @objc func handleSaveButton(){
        delegate?.handleSaveButton(
            model: FinancialAdministratorPendenciesListCardModel(
                title: nameValues.text,
                value: valueValues.text,
                name: descriptionValues.text,
                daysLate: Int(daysLateValues.text) ?? 0,
                proofUrl: url,
                userName: userNameValues.text,
                id: id))
    }
    
    @objc func handleAprooveButton(){
        delegate?.handleAprooveButton(
            model: FinancialAdministratorPendenciesListCardModel(
                title: nameValues.text,
                value: valueValues.text,
                name: descriptionValues.text,
                daysLate: Int(daysLateValues.text) ?? 0,
                proofUrl: url,
                userName: userNameValues.text,
                id: id))
    }
    
}
