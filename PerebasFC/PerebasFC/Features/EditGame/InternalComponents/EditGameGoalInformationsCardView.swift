//
//  EditGameGoalInformationsCardView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/06/23.
//

import UIKit

final class EditGameGoalInformationsCardView: UIView {
    
    private lazy var goalIndexLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        return label
    }()
    
    private lazy var playersPickerView: PickerComponent = {
        let picker = PickerComponent()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.title = "Selecione o jogador que marcou o gol: "
        
        var playerNames: [String] = []
        Session.shared.players.forEach { player in
            playerNames.append(player.firstName)
        }
        
        picker.values = playerNames
        
        return picker
    }()
    
    private lazy var timePickerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.text = "Selecione o tempo em que o gol foi marcado:"
        
        return label
    }()
    
    private lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .time
        
        return picker
    }()
    
    var player: String {
        get {
            return playersPickerView.selectedValue ?? String()
        }
    }
    
    var time: Date {
        get {
            return timePicker.date
        }
    }
    
    init(
        player: User?,
        time: Date?,
        index: String){
            super.init(frame: .zero)
            setupView()
            setupConstraints()
            updateView(
                player,
                time,
                index: index)
        }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateView(
        _ player: User? = nil,
        _ time: Date? = nil,
        index: String) {
            
            goalIndexLabel.text = index
            
            if let player = player {
                playersPickerView.selectRow(
                    didSelectRow: Session.shared.players.firstIndex(where: {  user in
                        user.firstName == player.firstName
                    }) ?? 0,
                    inComponent: 1)
            }
            
            if let time = time {
                timePicker.date = time
            }
    }
    
    private func setupView(){
        self.addSubviews([
            goalIndexLabel,
            timePickerLabel,
            playersPickerView,
            timePicker])
        setupBorders()
        backgroundColor = .systemYellow.withAlphaComponent(0.20)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 148),
            
            goalIndexLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            goalIndexLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            goalIndexLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            playersPickerView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            playersPickerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            playersPickerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            timePickerLabel.topAnchor.constraint(equalTo: playersPickerView.bottomAnchor, constant: 16),
            timePickerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            timePickerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            timePicker.topAnchor.constraint(equalTo: timePickerLabel.bottomAnchor, constant: 2),
            timePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            timePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    private func setupBorders(){
        layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 1
    }
    
}
