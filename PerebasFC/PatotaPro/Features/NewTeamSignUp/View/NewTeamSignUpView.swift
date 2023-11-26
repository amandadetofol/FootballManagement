//
//  NewTeamSignUpView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 04/11/23.
//

import UIKit
import YPImagePicker

protocol NewTeamSignUpViewDelegate: AnyObject {
    func handleCreateNewFootballTeam(model: NewTeamSignUpModel)
    func showColorContrastProblemAlert()
}

final class NewTeamSignUpView: UIView {
    
    var changeImage = false
    
    var imageSelectedPicker: UIImage?
    
    var model: NewTeamSignUpModel {
        get {
            return NewTeamSignUpModel(
                name: footballTeamTextField.text,
                profileImage: imageSelectedPicker ?? UIImage(),
                color: selectColorButton.backgroundColor ?? Session.shared.highLightColor,
                sumPointTeam: sumPointsTeamTextField.text,
                minPoinTeam: minPointsTeamTextField.text,
                sumPointGoal: sumUserPointsTeamTextField.text)
        }
    }
    
    weak var delegate: NewTeamSignUpViewDelegate?
    
    var footballTeamTextFieldHasError: Bool = false {
        didSet {
            footballTeamTextField.showError = true
        }
    }
    
    var sumPointsTeamTextFieldHasError: Bool = false {
        didSet {
            sumPointsTeamTextField.showError = true
        }
    }
    
    var minPointsTeamTextFieldHasError: Bool = false {
        didSet {
            minPointsTeamTextField.showError = true
        }
    }
    
    var sumUserPointsTeamTextFieldHasError: Bool = false {
        didSet {
            sumUserPointsTeamTextField.showError = true
        }
    }
    
    var sumPointsTeamTextFieldNotFloarError: Bool = false {
        didSet {
            sumPointsTeamTextField.errorMessage = "O valor precisa ser númerico."
            sumPointsTeamTextField.showError = true
        }
    }
    
    var minPointsTeamTextFielNotFloatdHasError: Bool = false {
        didSet {
            minPointsTeamTextField.errorMessage = "O valor precisa ser númerico."
            minPointsTeamTextField.showError = true
        }
    }
    
    var sumUserPointsTeamTextFieldNotFloatHasError: Bool = false {
        didSet {
            sumUserPointsTeamTextField.errorMessage = "O valor precisa ser númerico."
            sumUserPointsTeamTextField.showError = true
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height + 196)
        
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
    
    private lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
       
        return label
    }()

    private lazy var profileImageView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 140, weight: .bold, scale: .large)
        let image = UIImage(systemName: "photo.circle.fill", withConfiguration: largeConfig)
        
        button.setImage(image, for: .normal)
        button.accessibilityLabel =  "Insira o logo da patota aqui"
        button.addTarget(nil, action: #selector(showImagePicker), for: .touchUpInside)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.tintColor = .systemBlue
        button.imageView?.contentMode = .scaleAspectFill
        
        return button
    }()
    
    private lazy var imagePicker: YPImagePicker = {
        let picker = YPImagePicker()
        picker.didFinishPicking { [unowned picker, weak self] items, _ in
            if let photo = items.singlePhoto {
                self?.profileImageView.setImage(photo.image, for: .normal)
                self?.profileImageView.imageView?.contentMode = .scaleAspectFill
                self?.imageSelectedPicker = photo.image
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        return picker
    }()
    
    private lazy var footballTeamTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var explanationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
       
        return label
    }()
    
    private lazy var sumPointsTeamTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
      
        return textField
    }()
    
    private lazy var minPointsTeamTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
       
        return textField
    }()
    
    private lazy var sumUserPointsTeamTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
       
        return textField
    }()
    
    private lazy var selectColorButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.isHidden = true 
        button.setTitleColor(Session.shared.highLightColor, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleSelectColorButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleSignUpButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var colorpicker: UIColorPickerViewController = {
        let colorPicker = UIColorPickerViewController()
        colorPicker.title = "Cor de destaque do aplicativo"
        colorPicker.supportsAlpha = false
        colorPicker.delegate = self
        colorPicker.modalPresentationStyle = .popover
        
        return colorPicker
    }()
    
    private var controller: UIViewController
    
    init(controller: UIViewController){
        self.controller = controller
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(newTeamSignUpViewModel: NewTeamSignUpViewModel){
        profileLabel.text = newTeamSignUpViewModel.profileImageLabel
        footballTeamTextField.title = newTeamSignUpViewModel.nameTextFieldTitle
        explanationLabel.text = newTeamSignUpViewModel.explanationLabel
        sumPointsTeamTextField.title = newTeamSignUpViewModel.sumPointsTextFieldTitle
        minPointsTeamTextField.title = newTeamSignUpViewModel.minPointsTextFieldTitle
        sumUserPointsTeamTextField.title = newTeamSignUpViewModel.sumPointsGoalUserTextFieldTitle
        selectColorButton.setTitle(newTeamSignUpViewModel.colorPicker, for: .normal)
        confirmButton.setTitle(newTeamSignUpViewModel.continueButton, for: .normal)
    }
    
    private func setupView(){
        backgroundColor = .white
        addSubview(contentView)
        contentView.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubviews([
            profileLabel,
            profileImageView,
            footballTeamTextField,
            selectColorButton,
            explanationLabel,
            sumPointsTeamTextField,
            minPointsTeamTextField,
            sumUserPointsTeamTextField,
            confirmButton,
        ])
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
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            profileLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            profileImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            profileImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            
            footballTeamTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            footballTeamTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            selectColorButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            selectColorButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            selectColorButton.heightAnchor.constraint(equalToConstant: 48),
            
            explanationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            explanationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            sumPointsTeamTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            sumPointsTeamTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            minPointsTeamTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            minPointsTeamTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            sumUserPointsTeamTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            sumUserPointsTeamTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            confirmButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            confirmButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            confirmButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
}

extension NewTeamSignUpView: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.selectColorButton.backgroundColor = viewController.selectedColor
        self.selectColorButton.setTitleColor(.white, for: .normal)
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        if UIColor.contrastRatio(between: viewController.selectedColor, and: .white) <= 3 {
            delegate?.showColorContrastProblemAlert()
        }
    }
    
}

extension NewTeamSignUpView {
    
    @objc func showImagePicker(){
        controller.present(imagePicker, animated: true)
    }
    
    @objc func handleSelectColorButtonTap(){
        controller.present(colorpicker, animated: true)
    }
    
    @objc func handleSignUpButtonTap(){
        footballTeamTextField.showError = false
        sumPointsTeamTextField.showError = false
        minPointsTeamTextField.showError = false
        sumUserPointsTeamTextField.showError = false
        
        delegate?.handleCreateNewFootballTeam(model: model)
    }
    
}
