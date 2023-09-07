//
//  TextFieldComponentView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 15/05/23.
//

import UIKit

protocol TextFieldComponentDelegate: AnyObject {
    func textFieldDidEndEditing(_ textField: TextFieldComponent)
}

extension TextFieldComponentDelegate {
    func textFieldDidEndEditing(_ textField: TextFieldComponent) {}
}

final class TextFieldComponent: UIView {
    
    var showIcon = false
    
    var errorMessage: String = "" {
        didSet {
            errorLabel.text = errorMessage
            updateAcessibility(
                title: self.title,
                error: errorMessage)
        }
    }
    
    var showError = false {
        didSet {
            errorLabel.isHidden = !showError
            textField.layer.borderColor = showError ? UIColor.systemRed.cgColor : UIColor.black.cgColor
        }
    }
    
    var isSafeTextField = false {
        didSet {
            textField.isSecureTextEntry = isSafeTextField
        }
    }
    
    var text: String {
        get { return textField.text ?? String()}
        set { textField.text = newValue }
    }
    
    var placeholder: String = "" {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    var contentAsNumber: Int {
        get {
            return Int(textField.text ?? "") ?? 0
        }
    }
    
    var title: String = "" {
        didSet {
            titleLabel.text = title 
            titleLabel.isHidden = false
            updateAcessibility(
                title: title,
                error: nil)
        }
    }
    
    weak var delegate: TextFieldComponentDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.isHidden = true
        label.accessibilityIgnoresInvertColors = false
        label.isAccessibilityElement = false
        
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.accessibilityIgnoresInvertColors = false
        stackView.isAccessibilityElement = false
        
        return stackView
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.accessibilityIgnoresInvertColors = false
        
        return textField
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
        label.accessibilityIgnoresInvertColors = false
        label.isAccessibilityElement = false
        
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
    
    func showEyeButton(){
        showIcon = true
        let button = UIButton()
        button.setImage(
            UIImage(
                systemName: showIcon ? "eye.fill" : "eye.slash.fill"),
            for: .normal)
        button.addTarget(nil, action: #selector(handleEyeToggle), for: .touchUpInside)
        textField.rightView = button
        textField.rightViewMode = .always
    }
    
    func updateAcessibility(
        title: String?,
        error: String?){
            textField.accessibilityLabel =  "\(title ?? "") título. conteúdo do campo de texto \(text)  \(error ?? "")"
    }
    
    private func setupView(){
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(textField)
        contentStackView.addArrangedSubview(errorLabel)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 48),
            
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
}

extension TextFieldComponent: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.showError = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)  {
        delegate?.textFieldDidEndEditing(self)
    }
    
}

extension TextFieldComponent {
    
    @objc func handleEyeToggle(){
        showIcon.toggle()
        let button = UIButton()
        button.setImage(
            UIImage(
                systemName: showIcon ? "eye.fill" : "eye.slash.fill"),
            for: .normal)
        button.addTarget(nil, action: #selector(handleEyeToggle), for: .touchUpInside)
        textField.rightView = button
        textField.rightViewMode = .always
        textField.isSecureTextEntry = !showIcon
    }
    
}
