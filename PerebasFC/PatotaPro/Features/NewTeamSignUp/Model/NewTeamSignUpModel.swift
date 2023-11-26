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
    let sumPointsTextFieldTitle = "Pontos a somar no ranking (time):"
    let minPointsTextFieldTitle = "Pontos a diminiur no ranking (time):"
    let sumPointsGoalUserTextFieldTitle = "Pontos a somar no ranking (gol):"
    let colorPicker = "Selecione a cor de destaque"
    let continueButton = "Finalizar cadastro"
    let explanationLabel = """
    Sobre o funcionamento do ranking:
    - Quando um jogador marca um gol, ele ganha uma quantidade X de pontos.
    - Todos os membros do time vencedor recebem uma quantidade Y de pontos.
    - Todos os membros do time perdedor perdem uma quantidade Z de pontos.
    - Ganhar pontos implica em subir no ranking.
    - Perder pontos significa descer no ranking.
    Abaixo é necessário que voce insira os valores desejados para esta regra.
    """
}
