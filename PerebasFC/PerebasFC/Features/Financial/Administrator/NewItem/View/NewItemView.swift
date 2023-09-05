//
//  NewItemView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 17/08/23.
//

import UIKit

protocol NewItemViewDelegate: AnyObject {
    func handleConfirmButtonTap(newItem: NewItemModel)
    func handleAddToSpecificPlayerButton()
}

final class NewItemView: UIView {
    
    var selectedPlayer: String? {
        didSet {
            addToSpecificPlayerButton.setTitle(selectedPlayer, for: .normal)
        }
    }
    
    weak var delegate: NewItemViewDelegate?
    private var type: NewItemType?
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isAccessibilityElement = false
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.isAccessibilityElement = false
        
        return scrollView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(
            top: 16,
            left: 16,
            bottom: 16,
            right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        
        return stackView
    }()
    
    private lazy var operationDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var operationNameTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.title = "Descrição do item"
        
        return textField
    }()
    
    private lazy var valueNameTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.title = "Valor"
        textField.placeholder = "R$ --,--"
        
        return textField
    }()
    
    private lazy var datePickerTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        label.text = "Selecione uma data: "
        
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        
        return datePicker
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleConfirmButtonTap), for: .touchUpInside)
        button.setTitle("confirmer".uppercased(), for: .normal)
        
        return button
    }()
    
    private lazy var switchContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isAccessibilityElement = false
        
        return view
    }()
    
    private lazy var switchTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.text = "Dividir entre os memebros do time"
        
        return label
    }()
    
    private lazy var splitBeetweenTeamMemebersSwitch: UISwitch = {
        let myswitch = UISwitch()
        myswitch.translatesAutoresizingMaskIntoConstraints = false
        
        return myswitch
    }()
    
    private lazy var addToSpecificPlayerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("selecionar participante".uppercased(), for: .normal)
        button.backgroundColor = .brown
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(nil, action: #selector(handleAddToSpecificPlayerButton), for: .touchUpInside)
        
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
    
    func setupDescription(basedOn type: NewItemType){
        operationDescriptionLabel.text = type.rawValue
        switchContentView.isHidden = (type == .credit)
        addToSpecificPlayerButton.isHidden = type == .credit
    }
    
    private func setupView(){
        switchContentView.addSubviews([
            splitBeetweenTeamMemebersSwitch,
            switchTitleLabel])
        
        addSubview(contentView)
        contentView.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubviews([
            operationDescriptionLabel,
            operationNameTextField,
            valueNameTextField,
            datePickerTitleLabel,
            datePicker,
            addToSpecificPlayerButton,
            switchContentView,
            confirmButton
        ])
        
        backgroundColor = .white
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            switchContentView.heightAnchor.constraint(equalToConstant: 56),
            
            splitBeetweenTeamMemebersSwitch.centerYAnchor.constraint(equalTo: switchContentView.centerYAnchor),
            splitBeetweenTeamMemebersSwitch.leadingAnchor.constraint(equalTo: switchContentView.leadingAnchor),
            
            switchTitleLabel.topAnchor.constraint(equalTo: switchContentView.topAnchor, constant: 20),
            switchTitleLabel.leadingAnchor.constraint(equalTo:  switchContentView.leadingAnchor, constant: 56),
            switchTitleLabel.trailingAnchor.constraint(equalTo: switchContentView.trailingAnchor, constant: -16),
            
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
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
            
            operationDescriptionLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 16),
            operationDescriptionLabel.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -16),
            
            datePickerTitleLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 16),
            datePickerTitleLabel.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -16),
            
            datePicker.heightAnchor.constraint(equalToConstant: 48),
            
            confirmButton.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 16),
            confirmButton.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -16),
            confirmButton.heightAnchor.constraint(equalToConstant: 48),
            
            addToSpecificPlayerButton.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 16),
            addToSpecificPlayerButton.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -16),
            addToSpecificPlayerButton.heightAnchor.constraint(equalToConstant: 48),
            
        ])
    }
    
}

extension NewItemView {
    
    @objc func handleConfirmButtonTap(){
        delegate?.handleConfirmButtonTap(
            newItem: NewItemModel(
                eventName: operationNameTextField.text,
                eventValue: valueNameTextField.text,
                date: datePicker.date,
                type: type ?? .credit,
                splitBeetweenTeamMember: splitBeetweenTeamMemebersSwitch.isOn))
    }
    
    @objc func handleAddToSpecificPlayerButton(){
        delegate?.handleAddToSpecificPlayerButton()
    }
    
}
