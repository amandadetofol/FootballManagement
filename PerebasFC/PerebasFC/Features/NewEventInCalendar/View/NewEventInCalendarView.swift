//
//  NewEventInCalendarView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/07/23.
//

import UIKit

protocol NewEventInCalendarViewDelegate: AnyObject {
    func handleConfirmButtonTap(_ model: NewEventInCalendarViewModel)
}

final class NewEventInCalendarView: UIView {
    
    weak var delegate: NewEventInCalendarViewDelegate?
    var selectedDate: Date?
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
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
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16.0)
        
        return label
    }()
    
    private lazy var eventNameTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.title = "Nome do evento"
        
        return textField
    }()
    
    private lazy var hourTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.title = "Horário"
        
        return textField
    }()
    
    private lazy var isAllowedToTakeCompaniesSwitch: UISwitch = {
        let isAllowedSwitch = UISwitch()
        isAllowedSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        return isAllowedSwitch
    }()
    
    private lazy var isAllowedToTakeCompaniesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14.0)
        
        return label
    }()
    
    private lazy var companiesTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.title = "Quantidade de acompanhantes"
        textField.isHidden = true
        
        return textField
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.isHidden = true
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.setTitle("concluir".uppercased(), for: .normal)
        button.addTarget(self, action: #selector(handleConfirmButtonTap), for: .touchUpInside)
        
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
    
    private func setupView(){
        addSubview(contentView)
        contentView.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubviews([
            titleLabel,
            eventNameTextField,
            hourTextField,
            isAllowedToTakeCompaniesSwitch,
            isAllowedToTakeCompaniesLabel,
            companiesTextField,
            confirmButton])
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
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            eventNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            eventNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            hourTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            hourTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            isAllowedToTakeCompaniesLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            isAllowedToTakeCompaniesLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            companiesTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            companiesTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            confirmButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
}

extension NewEventInCalendarView {
    
    @objc func handleConfirmButtonTap(){
        guard let date = selectedDate else { return }
        //TODO: handle delegate
    }
    
}
