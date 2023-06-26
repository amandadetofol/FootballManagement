//
//  GameCardView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 30/05/23.
//

import UIKit

protocol GameCardViewDelegate: AnyObject {
    func handleEditGameButtonTap(game: Game)
}

final class GameCardView: UIView {
    
    weak var delegate: GameCardViewDelegate?
    private var model: Game?
    
    private lazy var blackTeamViewColorIndicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.clipsToBounds = true
        view.isAccessibilityElement = false
        
        return view
    }()
    
    private lazy var whiteTeamViewColorIndicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.isAccessibilityElement = false
        
        return view
    }()
    
    private lazy var whiteTeamScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 38.0)
        label.isAccessibilityElement = false
        
        return label
    }()
    
    private lazy var versusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "X"
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.isAccessibilityElement = false
        
        return label
    }()
    
    private lazy var blackTeamScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 38.0)
        label.isAccessibilityElement = false
        
        return label
    }()
    
    private lazy var gameDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.isAccessibilityElement = false
        
        return label
    }()
    
    private lazy var goalsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 0, bottom: -16, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        
        return stackView
    }()
    
    private lazy var editGameIcon: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemBlue
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(handleEditGameButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    init(){
        super.init(frame: .zero)
        setupView()
        setupConstraints()
        setupGameCardViewForAdm()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(with model: Game){
        whiteTeamScoreLabel.text = String(model.score?.whiteTeamPoints ?? 0)
        blackTeamScoreLabel.text = String(model.score?.blackTeamPoints ?? 0)
        gameDateLabel.text = model.gameDate
        
        model.goals?.forEach { goal in
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.textAlignment = .center
            label.text = goal.playerName + goal.time
            label.font = UIFont.boldSystemFont(ofSize: 16.0)
            label.isAccessibilityElement = false
            goalsStackView.addArrangedSubview(label)
            
            label.leadingAnchor.constraint(equalTo: goalsStackView.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: goalsStackView.trailingAnchor).isActive = true
        }
        backgroundColor = .systemYellow.withAlphaComponent(0.10)
        self.model = model
    }
    
    private func setupGameCardViewForAdm(){
        guard Session.shared.isAdm ?? false  else { return }
        editGameIcon.isHidden = false
    }
    
    private func setupView(){
        addSubviews([
            editGameIcon,
            blackTeamViewColorIndicator,
            whiteTeamViewColorIndicator,
            whiteTeamScoreLabel,
            blackTeamScoreLabel,
            versusLabel,
            goalsStackView,
            gameDateLabel
        ])
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 200),
            
            gameDateLabel.topAnchor.constraint(equalTo: topAnchor, constant: -28),
            gameDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            editGameIcon.topAnchor.constraint(equalTo: topAnchor, constant: -28),
            editGameIcon.heightAnchor.constraint(equalToConstant: 16),
            editGameIcon.widthAnchor.constraint(equalToConstant: 16),
            editGameIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            blackTeamViewColorIndicator.topAnchor.constraint(equalTo: topAnchor),
            blackTeamViewColorIndicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            blackTeamViewColorIndicator.heightAnchor.constraint(equalTo: self.heightAnchor),
            blackTeamViewColorIndicator.widthAnchor.constraint(equalToConstant: 16),
            
            blackTeamScoreLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            blackTeamScoreLabel.leadingAnchor.constraint(equalTo: blackTeamViewColorIndicator.trailingAnchor, constant: 16),
        
            whiteTeamViewColorIndicator.topAnchor.constraint(equalTo: topAnchor),
            whiteTeamViewColorIndicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            whiteTeamViewColorIndicator.heightAnchor.constraint(equalTo: self.heightAnchor),
            whiteTeamViewColorIndicator.widthAnchor.constraint(equalToConstant: 16),
            
            whiteTeamScoreLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            whiteTeamScoreLabel.trailingAnchor.constraint(equalTo: whiteTeamViewColorIndicator.leadingAnchor, constant: -16),
        
            versusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            versusLabel.leadingAnchor.constraint(equalTo: blackTeamScoreLabel.leadingAnchor),
            versusLabel.trailingAnchor.constraint(equalTo: whiteTeamScoreLabel.leadingAnchor),
            
            goalsStackView.topAnchor.constraint(equalTo: whiteTeamScoreLabel.bottomAnchor),
            goalsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            goalsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            goalsStackView.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }
    
    private func setupAccessibility(basedOn model: Game){
        self.isAccessibilityElement = true
        
        var result = ""
        if model.score?.blackTeamPoints ?? 0 > model.score?.whiteTeamPoints ?? 0 {
            result = "Time preto ganhou de \(model.score?.blackTeamPoints ?? 0) a \(model.score?.whiteTeamPoints ?? 0)"
        } else {
            result = "Time branco ganhou de \(model.score?.whiteTeamPoints ?? 0) a \(model.score?.blackTeamPoints ?? 0)"
        }
        
        var goals = ""
        model.goals?.forEach { goal in
            goals += "Gol de: \(goal.playerName) aos \(goal.time)"
        }
        
        accessibilityLabel = "Jogo do dia: \(model.gameDate). \(result) \(goals)"
    }
    
}

extension GameCardView {
    
    @objc func handleEditGameButtonTap(){
        guard let model = model else { return }
        delegate?.handleEditGameButtonTap(game: model)
    }
    
}
