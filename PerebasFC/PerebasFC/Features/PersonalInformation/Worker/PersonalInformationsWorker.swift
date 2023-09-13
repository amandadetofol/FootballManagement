//
//  PersonalInformationsWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import Foundation
import FirebaseFirestore

protocol PersonalInformationsWorkerProtocol {
    func getPersonalInformations(
        _ completion: @escaping ((PersonalInformationsViewModel?) -> Void))
    func updatePersonalInformations(
        personalInformations: PersonalInformationsViewModel,
        completion: @escaping((Bool)->Void))
}

final class PersonalInformationsWorker: PersonalInformationsWorkerProtocol {
    
    private let firestoreProvider = Firestore.firestore()
   
    func getPersonalInformations(_ completion: @escaping ((PersonalInformationsViewModel?) -> Void)) {
        firestoreProvider.document("perebasfc/\(Session.shared.loggedUserEmail ?? "")").getDocument { document, error in
            guard error == nil else {
                completion(nil)
                return
            }
            
            completion(
                PersonalInformationsViewModel(
                    name: document?["name"] as? String ?? "",
                    lastName: document?["lastname"] as? String ?? "",
                    birthDate: document?["date"] as? Date ?? Date(),
                    position: document?["position"] as? String ?? "",
                    shirtNumber: document?["shirtNumber"] as? String ?? "",
                    type: MemberType(rawValue: document?["memberType"] as? String ?? "") ?? .player,
                    medicalInsurance: document?["medicalInsurance"] as? String ?? "SUS",
                    emergencyPhoneNumber: document?["emergencyPhoneNumber"] as? String  ?? "",
                    category: document?["category"] as? String ?? "",
                    image: document?["userImage"] as? Data ?? Data())) 
        }
    }
    
    func updatePersonalInformations(
        personalInformations: PersonalInformationsViewModel,
        completion: @escaping((Bool)->Void)) {
            firestoreProvider.document("perebasfc/\(Session.shared.loggedUserEmail ?? "")").setData([
                "name": personalInformations.name,
                "lastname": personalInformations.lastName,
                "date": personalInformations.birthDate,
                "position": personalInformations.position,
                "shirtNumber": personalInformations.shirtNumber,
                "type": personalInformations.type.rawValue,
                "medicalInsurance": personalInformations.medicalInsurance,
                "emergencyPhoneNumber": personalInformations.emergencyPhoneNumber,
                "category": personalInformations.category,
                "image": personalInformations.image
            ])
            completion(true)
        }
    
}
