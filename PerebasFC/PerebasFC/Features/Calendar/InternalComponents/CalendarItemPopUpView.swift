//
//  CalendarItemPopUpView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 12/06/23.
//

import UIKit

protocol CalendarItemPopUpViewDelegate: AnyObject {
    func handleFirstActionButtonTap(
        key: String,
        date: Date)
    func handleSecondActionButtonTap(
        key: String,
        date: Date)
}

final class CalendarItemPopUpView: UIControl {
    
    weak var delegate: CalendarItemPopUpViewDelegate?
    
    var selectedDate: Date? = nil
    
    private var firstActionKey: String = ""
    private var secondActionKey: String = ""
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16.0)
        
        return label
    }()
    
    private lazy var firstActionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleFirstActionButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var secondActionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.isHidden = true
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleSecondActionButtonTap), for: .touchUpInside)
        
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
    
    func updateView(
        with model: CalendarItemPopUpViewModel,
        date: Date){
            updateAccessibility(model: model)
            titleLabel.text = model.title
            descriptionLabel.text = model.description
            firstActionButton.setTitle(model.firstActionTitle, for: .normal)
            firstActionKey = model.firstActionKey
            
            if let secondAction = model.secondActionTitle {
                secondActionButton.setTitle(secondAction, for: .normal)
                secondActionButton.isHidden = false
            }
            
            if let secondActionKey = model.secondActionKey {
                self.secondActionKey = secondActionKey
            }
            
            self.selectedDate = date
        }
    
    private func updateAccessibility(model: CalendarItemPopUpViewModel){
        self.isAccessibilityElement = true
        self.accessibilityTraits = .button
        self.accessibilityLabel = model.description + model.firstActionTitle
        
        if UIAccessibility.isVoiceOverRunning {
            addTarget(self, action: #selector(handleSecondActionButtonTap), for: .touchUpInside)
        }
    }
    
    private func setupView(){
        addSubviews([
            titleLabel,
            descriptionLabel,
            firstActionButton,
            secondActionButton])
        backgroundColor = .white
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.50).cgColor
        layer.borderWidth = 1
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 200),
            
            secondActionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            secondActionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            secondActionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            secondActionButton.heightAnchor.constraint(equalToConstant: 48),
            
            firstActionButton.bottomAnchor.constraint(equalTo: secondActionButton.topAnchor, constant: -16),
            firstActionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            firstActionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            firstActionButton.heightAnchor.constraint(equalToConstant: 48),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: firstActionButton.topAnchor, constant: -16),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: -32),
        ])
    }
    
}

extension CalendarItemPopUpView {
    
    @objc func handleFirstActionButtonTap(){
        delegate?.handleFirstActionButtonTap(
            key: self.firstActionKey,
            date: selectedDate ?? Date())
    }
    
    @objc func handleSecondActionButtonTap(){
        delegate?.handleSecondActionButtonTap(
            key: self.secondActionKey,
            date: selectedDate ?? Date())
    }
    
}
