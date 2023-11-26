//
//  PickerComponent.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/06/23.
//

import UIKit

final class PickerComponent: UIView {
    
    var selectedValue: String?

    var errorMessage: String = "" {
        didSet {
            errorLabel.text = errorMessage
        }
    }
    
    var showError = false {
        didSet {
            errorLabel.isHidden = !showError
            pickerView.layer.borderColor = showError ? UIColor.systemRed.cgColor : UIColor.black.cgColor
        }
    }
    
    var values: [String] = [] {
        didSet {
            pickerView.reloadAllComponents()
        }
    }
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
            titleLabel.isHidden = false
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.isHidden = true
        
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 2
        
        return stackView
    }()
    
    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self
        picker.dataSource = self
        
        return picker
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 14)
        label.isHidden = true
        label.text = "Campo obrigatório."
        
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectRow(didSelectRow row: Int, inComponent component: Int) {
        self.pickerView.selectRow(row, inComponent: component, animated: false)
    }
    
    private func setupView(){
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(pickerView)
        contentStackView.addArrangedSubview(errorLabel)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 96),
            
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            pickerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            pickerView.heightAnchor.constraint(equalToConstant: 48),
            
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
}

extension PickerComponent: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectedValue = values[row]
        return values[row]
    }
    
}
