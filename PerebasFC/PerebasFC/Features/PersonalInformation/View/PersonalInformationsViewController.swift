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
    func handleGoToBlockEdition()
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Editar",
            style: .plain,
            target: self,
            action: #selector(handleGoToEditDataFlowSelected))
        handleKeyBoardRemoveWhenClickOutsideField()
    }
    
}
 
extension PersonalInformationsViewController: PersonalInformationsViewDelegate {
    
    func handleDeleteUserButtonTap(user: PersonalInformationsViewModel) {
        interactor.handleDeleteUserButtonTap(user: user)
    }
    
    func handleGoToPasswordFlowButtonTap() {
        interactor.handleGoToChangePasswordFlow()
    }
    
}

extension PersonalInformationsViewController {
    
    @objc func handleGoToEditDataFlowSelected(){
        interactor.handleGoToEditDataFlow()
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
        personalInformationsView.enableEdition()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
         title: "Ok",
         style: .plain,
         target: self,
         action: #selector(handleGoToBlockEdition))
        personalInformationsView.updateAccessibiltiy(isEnabledForEdition: true)
        personalInformationsView.setupPlayerCategoryField(isEnabledForEdition: true)
    }
    
    @objc func handleGoToBlockEdition(){
        interactor.handleEdit(
            model: personalInformationsView.modifiedModel,
            changeImage: personalInformationsView.changeImage)
    }
    
    func handleEdit(){
        personalInformationsView.userNameTextFieldHasError = false
        personalInformationsView.lastNameTextFieldHasError = false
        personalInformationsView.shirtNumberTextFieldHasError = false
        personalInformationsView.positionNumberTextFieldHasError = false
        personalInformationsView.medicalInsuranceTextFieldHasError = false
        personalInformationsView.emergencyPhoneNumberTextFieldHasError = false
        personalInformationsView.disableEdition()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Editar",
            style: .plain,
            target: self,
            action: #selector(handleGoToEditDataFlowSelected))
        personalInformationsView.updateAccessibiltiy(isEnabledForEdition: false)
        personalInformationsView.setupPlayerCategoryField(isEnabledForEdition: false)
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
