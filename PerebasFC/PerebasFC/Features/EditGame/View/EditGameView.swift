//
//  EditGameView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/06/23.
//

import UIKit

protocol EditGameViewDelegate: AnyObject {
    func handleGoToBackButtonTap()
    func handleSaveNewGameInformationsButtonTap(game: Game)
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
    
    private lazy var datePickerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.text = "Data do jogo"
        
        return label
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
    
    private lazy var goalsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 0, bottom: -16, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        
        return stackView
    }()
    
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
    
    init(){
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(with game: Game) {
        datePickerView.date = game.date 
        whiteLabelScoreTextField.text = String(game.score?.whiteTeamPoints ?? 0)
        blackLabelScoreTextField.text = String(game.score?.blackTeamPoints ?? 0)
        goalsNumberLabel.text = String(game.score?.totalPoints ?? 0)
        saveButton.setTitle("salvar".uppercased(), for: .normal)
        gotoBackButton.setTitle("voltar".uppercased(), for: .normal)
        
        game.goals?.forEach({ goal in
            let goalCard = EditGameGoalInformationsCardView(
                player: goal.player,
                time: goal.time,
                index: String(goal.index))
            goalsStackView.addArrangedSubview(goalCard)
        })
    }
    
    private func setupView(){
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubviews([
            datePickerLabel,
            datePickerView,
            whiteLabelScoreTextField,
            blackLabelScoreTextField,
            goalsNumberLabel,
            goalsStackView,
            saveButton,
            gotoBackButton])
        contentStackView.setCustomSpacing(4, after: datePickerLabel)
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
        
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            datePickerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            datePickerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            datePickerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            datePickerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            datePickerView.heightAnchor.constraint(equalToConstant: 48),
            
            whiteLabelScoreTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            whiteLabelScoreTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            blackLabelScoreTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            blackLabelScoreTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            goalsNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            goalsNumberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            goalsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            goalsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 48),
            
            gotoBackButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            gotoBackButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            gotoBackButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
}

extension EditGameView {
    
    @objc func handleGoToBackButtonTap(){
        delegate?.handleGoToBackButtonTap()
    }
    
    @objc func handleSaveNewGameInformationsButtonTap(){
        var goals: [Goals]? = nil
        goalsStackView.arrangedSubviews.forEach { subview in
            guard let goal = subview as? EditGameGoalInformationsCardView,
                  let model = goal.model  else { return }
            goals?.append(model)
        }
        
        delegate?.handleSaveNewGameInformationsButtonTap(game: Game(
            score: Score(
                whiteTeamPoints: Int(whiteLabelScoreTextField.text) ?? 0,
                blackTeamPoints: Int(blackLabelScoreTextField.text) ?? 0),
            gameDate: datePickerView.date.toString(),
            goals: goals,
            date: datePickerView.date))
    }
    
}
