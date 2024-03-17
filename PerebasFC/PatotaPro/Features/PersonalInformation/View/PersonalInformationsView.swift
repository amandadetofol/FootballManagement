//
//  PersonalInformationsView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import UIKit
import YPImagePicker

protocol PersonalInformationsViewDelegate: AnyObject {
    func handleGoToPasswordFlowButtonTap()
    func handleOkFormButtonTap()
    func handleDeleteUserButtonTap(user: PersonalInformationsViewModel)
}

final class PersonalInformationsView: UIView {
    
    var changeImage = false
    var imageSelectedPicker: UIImage?
    var modifiedModel: PersonalInformationsViewModel {
        get {
            return PersonalInformationsViewModel(
                name: userNameTextField.text,
                lastName: lastNameTextField.text,
                birthDate: birthDatePicker.date,
                position: positionNumberTextField.text,
                shirtNumber: shirtNumberTextField.text,
                type: MemberType(rawValue: userTypeTextField.text) ?? .player,
                medicalInsurance: medicalInsuranceTextField.text,
                emergencyPhoneNumber: emergencyPhoneNumberTextField.text,
                category: playerCategoryTextField.text,
                image: imageSelectedPicker ?? UIImage())
        }
    }
    
    var hideDeleteButton: Bool = false {
        didSet {
            deleteUserButton.isHidden = hideDeleteButton
        }
    }
    
    var model: PersonalInformationsViewModel?
    var controller: UIViewController?
    weak var delegate: PersonalInformationsViewDelegate?
    
    var userNameTextFieldHasError: Bool = false {
        didSet {
            userNameTextField.showError = userNameTextFieldHasError
        }
    }
    
    var lastNameTextFieldHasError: Bool = false {
        didSet {
            lastNameTextField.showError = lastNameTextFieldHasError
        }
    }
    
    var shirtNumberTextFieldHasError: Bool = false {
        didSet {
            shirtNumberTextField.showError = shirtNumberTextFieldHasError
        }
    }
    
    var positionNumberTextFieldHasError: Bool = false {
        didSet {
            positionNumberTextField.showError = positionNumberTextFieldHasError
        }
    }
    
    var medicalInsuranceTextFieldHasError: Bool = false {
        didSet {
            medicalInsuranceTextField.showError = medicalInsuranceTextFieldHasError
        }
    }
    
    var emergencyPhoneNumberTextFieldHasError: Bool = false {
        didSet {
            emergencyPhoneNumberTextField.showError = emergencyPhoneNumberTextFieldHasError
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
    
    private lazy var profileImageView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 140, weight: .bold, scale: .large)
        let image = UIImage(systemName: "person.circle.fill", withConfiguration: largeConfig)
        
        button.setImage(image, for: .normal)
        button.accessibilityLabel =  "Selecione uma foto de perfil"
        button.addTarget(nil, action: #selector(showImagePicker), for: .touchUpInside)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.tintColor = .systemBlue
        button.imageView?.contentMode = .scaleAspectFill
        button.isUserInteractionEnabled = false
        
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
        datePicker.isHidden = true 
        
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
    
    private lazy var positionNumberTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Posição"
        textField.isUserInteractionEnabled = false
        textField.title = "Posição do jogador em campo"
        
        return textField
    }()
    
    private lazy var playerCategoryTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "A"
        textField.isUserInteractionEnabled = false
        textField.title = "Categoria do Jogador"
        
        return textField
    }()
    
    private let playerCategoryPicker: PickerComponent = {
        let picker = PickerComponent()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.values = ["A", "B", "C"]
        picker.title = "Categoria do Jogador"
        
        return picker
    }()
    
    private lazy var userTypeTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Tipo de participante"
        textField.isUserInteractionEnabled = false
        textField.title = "Tipo de participante"
        
        return textField
    }()
    
    
    private let userTypePicker: PickerComponent = {
        let picker = PickerComponent()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.values = ["Jogador", "Goleiro", "Participante"]
        picker.title = "Tipo de participante"
        
        return picker
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
    
    private lazy var saveFormButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitle("Salvar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleOkFormButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var changePasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitle("Alterar senha", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black.withAlphaComponent(0.50)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleGoToPasswordFlowButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var deleteUserButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = Session.shared.highLightColor
        button.setTitle("   Excluir", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleDeleteUserButtonTap), for: .touchUpInside)
       
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
        positionNumberTextField.text = model.position
        playerCategoryTextField.text = model.category
        
        if let image = model.image {
            profileImageView.setImage(image, for: .normal)
        }
        
        if let img = model.imageUrl {
            downloadImage(from: img) { [weak self] image in
                guard let self else { return }
                if let image {
                    DispatchQueue.main.async {
                        self.profileImageView.setImage(image, for: .normal)
                    }
                }
            }
        }
        
        self.model = model
    }
    
    func updateAccessibiltiy(isEnabledForEdition: Bool) {
        self.isAccessibilityElement = true
        self.accessibilityLabel = isEnabledForEdition ? "Tela de dados pessoais: habilitado para edição" : "Tela de dados pessoais: somente leitura"
    }
    
    func setupPlayerCategoryField(isEnabledForEdition: Bool){
        profileImageView.isUserInteractionEnabled = isEnabledForEdition
        
        if !isEnabledForEdition {
            playerCategoryTextField.text = playerCategoryPicker.selectedValue ?? "Indefinido"
            userTypeTextField.text = userTypePicker.selectedValue ?? "Indefinido"
        }
    }
    
    private func setupView(){
        addSubview(scrollView)
        scrollView.addSubviews([contentView])
        contentView.addSubview(stackView)
        stackView.addArrangedSubviews([
            profileImageView,
            userNameTextField,
            lastNameTextField,
            birthDatePicker,
            shirtNumberTextField,
            positionNumberTextField,
            userTypePicker,
            playerCategoryPicker,
            medicalInsuranceTextField,
            emergencyPhoneNumberTextField,
            saveFormButton,
            changePasswordButton,
            deleteUserButton])
        stackView.setCustomSpacing(32, after: emergencyPhoneNumberTextField)
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
            
            changePasswordButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            changePasswordButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            changePasswordButton.heightAnchor.constraint(equalToConstant: 48),
            
            saveFormButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            saveFormButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            saveFormButton.heightAnchor.constraint(equalToConstant: 48),
            
            deleteUserButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            deleteUserButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            deleteUserButton.heightAnchor.constraint(equalToConstant: 48),
            
            userNameTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            userNameTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            
            lastNameTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            lastNameTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            
            birthDatePicker.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            birthDatePicker.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            
            shirtNumberTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            shirtNumberTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            
            positionNumberTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            positionNumberTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            
            medicalInsuranceTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            medicalInsuranceTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            
            emergencyPhoneNumberTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            emergencyPhoneNumberTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            
            playerCategoryPicker.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            playerCategoryPicker.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            
            profileImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            profileImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
        ])
    }
    
    private func downloadImage(
        from string: String,
        completion: @escaping (UIImage?) -> Void) {
            
            guard let url = URL(string: string) else { return }
            URLSession.shared.dataTask(with: url) { data, _, error in
                if error != nil {
                    completion(nil)
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            }.resume()
        }

    
}

extension PersonalInformationsView {
    
    @objc func handleGoToPasswordFlowButtonTap(){
        delegate?.handleGoToPasswordFlowButtonTap()
    }
    
    @objc func handleDeleteUserButtonTap(){
        guard let model = model else { return }
        delegate?.handleDeleteUserButtonTap(user: model)
    }
    
    @objc func showImagePicker(){
        controller?.present(imagePicker, animated: true)
        changeImage = true 
    }
    
    @objc func handleOkFormButtonTap(){
        delegate?.handleOkFormButtonTap()
    }
    
}
