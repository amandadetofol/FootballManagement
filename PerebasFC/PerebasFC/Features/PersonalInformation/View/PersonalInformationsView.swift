//
//  PersonalInformationsView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import UIKit

protocol PersonalInformationsViewDelegate: AnyObject {
    func handleGoToPasswordFlowButtonTap()
}

final class PersonalInformationsView: UIView {
    
    weak var delegate: PersonalInformationsViewDelegate?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isAccessibilityElement = false
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: -16, right: -16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        stackView.isAccessibilityElement = false
        
        return stackView
    }()
    
    private lazy var userNameTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Nome"
        textField.isUserInteractionEnabled = false
        textField.title = "Nome"
        
        return textField
    }()
    
    private lazy var lastNameTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Sobrenome"
        textField.isUserInteractionEnabled = false
        textField.title = "Sobrenome"
        
        return textField
    }()
    
    private lazy var birthDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.isUserInteractionEnabled = false
        
        return datePicker
    }()

    
    private lazy var shirtNumberTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Número da camisa"
        textField.isUserInteractionEnabled = false
        textField.title = "Número da camisa"
        
        return textField
    }()
    
    
    private lazy var userTypeTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Tipo de participante"
        textField.isUserInteractionEnabled = false
        textField.title = "Tipo de participante"
        
        return textField
    }()
    
    private lazy var medicalInsuranceTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Convênio"
        textField.isUserInteractionEnabled = false
        textField.title = "Convênio"
        
        return textField
    }()
    
    private lazy var emergencyPhoneNumberTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Telefone em caso de emergência"
        textField.isUserInteractionEnabled = false
        textField.title = "Telefone em caso de emergência"
        
        return textField
    }()
    
    private lazy var buttonBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.isAccessibilityElement = false
        
        return view
    }()
    
    private lazy var changePasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitle("alterar senha".uppercased(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleGoToPasswordFlowButtonTap), for: .touchUpInside)
     
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
    
    func enableEdition(){
        DispatchQueue.main.async {
            self.stackView.arrangedSubviews.forEach { view in
                view.isUserInteractionEnabled = true
            }
        }
    }
    
    func disableEdition(){
        DispatchQueue.main.async {
            self.stackView.arrangedSubviews.forEach { view in
                view.isUserInteractionEnabled = false 
            }
        }
    }
    
    func updateView(with model: PersonalInformationsViewModel){
        userNameTextField.text = model.name
        lastNameTextField.text = model.lastName
        birthDatePicker.date = model.birthDate
        userTypeTextField.text = model.type.rawValue
        shirtNumberTextField.text = model.shirtNumber
        medicalInsuranceTextField.text = model.medicalInsurance
        emergencyPhoneNumberTextField.text = model.emergencyPhoneNumber
    }
    
    private func setupView(){
        addSubview(scrollView)
        scrollView.addSubviews([contentView, buttonBackgroundView])
        contentView.addSubview(stackView)
        buttonBackgroundView.addSubview(changePasswordButton)
        stackView.addArrangedSubviews([
            userNameTextField,
            lastNameTextField,
            birthDatePicker,
            shirtNumberTextField,
            userTypeTextField,
            medicalInsuranceTextField,
            emergencyPhoneNumberTextField])
        backgroundColor = .white
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -96),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            
            buttonBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            buttonBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            buttonBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            buttonBackgroundView.heightAnchor.constraint(equalToConstant: 96),
            
            changePasswordButton.leadingAnchor.constraint(equalTo: buttonBackgroundView.leadingAnchor, constant: 16),
            changePasswordButton.trailingAnchor.constraint(equalTo: buttonBackgroundView.trailingAnchor, constant: -16),
            changePasswordButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            changePasswordButton.heightAnchor.constraint(equalToConstant: 48),
            
            userNameTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            userNameTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
    
            lastNameTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            lastNameTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            
            birthDatePicker.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            birthDatePicker.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            
            shirtNumberTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            shirtNumberTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            
            userTypeTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            userTypeTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            
            medicalInsuranceTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            medicalInsuranceTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            
            emergencyPhoneNumberTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            emergencyPhoneNumberTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
        ])
    }
}

extension PersonalInformationsView {
    
    @objc func handleGoToPasswordFlowButtonTap(){
        delegate?.handleGoToPasswordFlowButtonTap()
    }
    
}
