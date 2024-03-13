//
//  NewTeamSignUpModel.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 04/11/23.
//

import UIKit

struct NewTeamSignUpModel {
    var name: String
    var profileImage: UIImage
    var color: UIColor
    var sumPointTeam: String
    var minPoinTeam: String
    var sumPointGoal: String
}

struct NewTeamSignUpViewModel {
    let profileImageLabel = "Logo da patota"
    let nameTextFieldTitle = "Nome da patota"
    let sumPointsTextFieldTitle = "Pontos a somar no ranking quando o time ganha o jogo:"
    let minPointsTextFieldTitle = "Pontos a descontar no ranking quando o time perde o jogo:"
    let sumPointsGoalUserTextFieldTitle = "Pontos a somar no ranking quando jogador marca gol:"
    let colorPicker = "Selecione a cor de destaque"
    let continueButton = "Finalizar cadastro"
    let explanationLabel = ""
}
