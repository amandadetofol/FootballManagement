//
//  PersonalInformationsWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore

protocol PersonalInformationsWorkerProtocol {
    func getPersonalInformations(
        _ completion: @escaping ((PersonalInformationsViewModel?) -> Void))
    func updatePersonalInformations(
        personalInformations: PersonalInformationsViewModel,
        changeImage: Bool,
        completion: @escaping((Bool)->Void))
}

final class PersonalInformationsWorker: PersonalInformationsWorkerProtocol {
    
    private let firestoreProvider = Firestore.firestore()
    
    func getPersonalInformations(_ completion: @escaping ((PersonalInformationsViewModel?) -> Void)) {
        firestoreProvider.document("perebasfc/\(Session.shared.loggedUserEmail ?? "")").getDocument { [weak self] document, error in
            guard error == nil,
                  let self = self else {
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
                    image: nil,
                    imageUrl: document?["image"] as? String ?? ""))
        }
    }
    
    func updatePersonalInformations(
        personalInformations: PersonalInformationsViewModel,
        changeImage: Bool,
        completion: @escaping((Bool)->Void)) {
            firestoreProvider.document("perebasfc/\(Session.shared.loggedUserEmail ?? "")").updateData([
                "name": personalInformations.name,
                "lastname": personalInformations.lastName,
                "date": personalInformations.birthDate,
                "position": personalInformations.position,
                "shirtNumber": personalInformations.shirtNumber,
                "type": personalInformations.type.rawValue,
                "medicalInsurance": personalInformations.medicalInsurance,
                "emergencyPhoneNumber": personalInformations.emergencyPhoneNumber,
                "category": personalInformations.category,
            ], completion: { error in
                guard error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            })
            
            if changeImage {
                uploadImage(image: personalInformations.image ?? UIImage())
            }
        }
    
    //MARK: Private methods
    private func uploadImage(image: UIImage){
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let imageRef = storageReference.child("images/\(Session.shared.loggedUserEmail ?? "").jpg")
        
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            imageRef.putData(imageData, metadata: nil) { [weak self] (metadata, error) in
                guard error == nil else { return }
                
                imageRef.downloadURL { (url, error) in
                    if let downloadURL = url {
                        self?.firestoreProvider.document(
                            "perebasfc/\(Session.shared.loggedUserEmail ?? "")").updateData(["image": downloadURL.absoluteString])
                    }
                }
                
            }
        }
    }
   
}
