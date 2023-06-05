//
//  PersonalInformationsViewModel.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import Foundation

struct PersonalInformationsViewModel {
    let name: String
    let lastName: String
    let birthDate: Date
    let position: String
    let shirtNumber: String
    let type: MemberType
    let medicalInsurance: String
    let emergencyPhoneNumber: String
}

enum MemberType: String {
    case player = "Jogador"
    case participant = "Participante"
    case goalKeeper = "Goleiro"
}
