//
//  PickerComponent.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 05/06/23.
//

import UIKit

final class PickerComponent: UIView {
    
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
    
    var pickerOptions: [String] = [] {
        didSet {
            pickerView.reloadAllComponents()
        }
    }
    
    var selectedItem: String?
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = self
        pickerView.dataSource = self
        
        return pickerView
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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.backgroundColor = .clear
        stackView.isAccessibilityElement = false
        
        return stackView
    }()
    
    init(){
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectRow(_ row: Int, inComponent: Int, animated: Bool){
        pickerView.selectRow(row, inComponent: inComponent, animated: animated)
    }
  
    private func setupView(){
        addSubview(stackView)
        stackView.addArrangedSubviews([pickerView, errorLabel])
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            
            pickerView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
        
            errorLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
        ])
    }
    
}

extension PickerComponent: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerOptions.count
    }
    
}

extension PickerComponent: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedItem = pickerOptions[row]
    }
    
}
