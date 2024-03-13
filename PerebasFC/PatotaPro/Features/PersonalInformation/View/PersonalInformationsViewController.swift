//
//  PersonalInformationsViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import UIKit

protocol PersonalInformationsInteractorProtocol {
    func viewDidLoad()
    func handleGoToChangePasswordFlow()
    func handleGoToEditDataFlow()
    func handleDeleteUserButtonTap(user: PersonalInformationsViewModel)
    func handleEdit(
        model: PersonalInformationsViewModel,
        changeImage: Bool)
}

final class PersonalInformationsViewController: UIViewController {
    
    var model: PersonalInformationsViewModel?
    
    private lazy var personalInformationsView: PersonalInformationsView = {
        let view = PersonalInformationsView()
        view.delegate = self
        view.controller = self
        view.enableEdition()
        
        return view
    }()
    
    private let interactor: PersonalInformationsInteractorProtocol
    
    init(interactor: PersonalInformationsInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
       
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = personalInformationsView 
        interactor.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        title = "Dados Pessoais"
        handleKeyBoardRemoveWhenClickOutsideField()
    
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.personalInformationsView.scrollView.frame.origin.y >= 0 {
                self.personalInformationsView.scrollView.frame.origin.y -= keyboardSize.height/2
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.personalInformationsView.scrollView.frame.origin.y = 0
    }
    
}
 
extension PersonalInformationsViewController: PersonalInformationsViewDelegate {
    func handleOkFormButtonTap() {
        interactor.handleEdit(
            model: personalInformationsView.modifiedModel,
            changeImage: personalInformationsView.changeImage)
    }
    
    
    func handleDeleteUserButtonTap(user: PersonalInformationsViewModel) {
        interactor.handleDeleteUserButtonTap(user: user)
    }
    
    func handleGoToPasswordFlowButtonTap() {
        interactor.handleGoToChangePasswordFlow()
    }
    
}

extension PersonalInformationsViewController: PersonalInformationsViewProtocol {

    func hideDeleteButton() {
        personalInformationsView.hideDeleteButton = true 
    }
    
    func updateView(with model: PersonalInformationsViewModel) {
        personalInformationsView.updateView(with: model)
    }
    
    func handleGoToEditDataFlow() {
        personalInformationsView.updateAccessibiltiy(isEnabledForEdition: true)
        personalInformationsView.setupPlayerCategoryField(isEnabledForEdition: true)
    }
    
    func handleEdit(){
        personalInformationsView.userNameTextFieldHasError = false
        personalInformationsView.lastNameTextFieldHasError = false
        personalInformationsView.shirtNumberTextFieldHasError = false
        personalInformationsView.positionNumberTextFieldHasError = false
        personalInformationsView.medicalInsuranceTextFieldHasError = false
        personalInformationsView.emergencyPhoneNumberTextFieldHasError = false
    }
    
    func setupViewForUserNameTextFieldErrror(){
        personalInformationsView.userNameTextFieldHasError = true
    }
    
    func setupViewForLastNameTextFieldError(){
        personalInformationsView.lastNameTextFieldHasError = true
    }
    
    func setupViewForShirtNumberTextFieldError(){
        personalInformationsView.shirtNumberTextFieldHasError = true
    }
    
    func setupViewForPositionNumberTextFieldHasError(){
        personalInformationsView.positionNumberTextFieldHasError = true
    }
    
    func setupViewForMedicalInsuranceTextFieldError(){
        personalInformationsView.medicalInsuranceTextFieldHasError = true
    }
    
    func setupViewForEmergencyPhoneNumberTextFieldError(){
        personalInformationsView.emergencyPhoneNumberTextFieldHasError = true
    }
    
}
