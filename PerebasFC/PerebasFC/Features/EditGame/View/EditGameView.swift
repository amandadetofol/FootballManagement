//
//  EditGameView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/06/23.
//

import UIKit

protocol EditGameViewDelegate: AnyObject {
    func handleGoToBackButtonTap()
    func handleSaveNewGameInformationsButtonTap()
}

final class EditGameView: UIView {
    
    weak var delegate: EditGameViewDelegate?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.isAccessibilityElement = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isAccessibilityElement = false 
        
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(top: 32, left: 32, bottom: -32, right: -32)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        
        return stackView
    }()
    
    private lazy var datePickerView: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = true
        
        return datePicker
    }()
    
    private lazy var whiteLabelScoreTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.title = "Placar (Time Branco)"
        textField.placeholder = "0"
        
        return textField
    }()
    
    private lazy var blackLabelScoreTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.title = "Placar (Time Preto)"
        textField.placeholder = "0"
        
        return textField
    }()
    
    private lazy var goalsNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.text = "Quantidade de gols: "
        
        return label
    }()
    
    //para cada gol -> jogador que fez a jogada(picker dos jogadores) e tempo
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.isHidden = true
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleSaveNewGameInformationsButtonTap), for: .touchUpInside)
        
        return button
    }()

    private lazy var gotoBackButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.isHidden = true
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleGoToBackButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    init(game: Game){
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension EditGameView {
    
    @objc func handleGoToBackButtonTap(){
        delegate?.handleGoToBackButtonTap()
    }
    
    @objc func handleSaveNewGameInformationsButtonTap(){
        delegate?.handleSaveNewGameInformationsButtonTap()
    }
    
}
