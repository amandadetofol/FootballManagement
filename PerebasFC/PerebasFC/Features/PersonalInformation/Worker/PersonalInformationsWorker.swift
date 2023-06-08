//
//  PersonalInformationsWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import Foundation

protocol PersonalInformationsWorkerProtocol {
    func getPersonalInformations(
        _ completion: @escaping ((PersonalInformationsViewModel?) -> Void))
}

final class PersonalInformationsWorker: PersonalInformationsWorkerProtocol {
   
    func getPersonalInformations(_ completion: @escaping ((PersonalInformationsViewModel?) -> Void)) {
        completion(PersonalInformationsViewModel(
            name: "John",
            lastName: "Doe",
            birthDate: Date(),
            position: "Forward",
            shirtNumber: "10",
            type: .player,
            medicalInsurance: "ABC123",
            emergencyPhoneNumber: "123456789"
        ))
    }
    
}
