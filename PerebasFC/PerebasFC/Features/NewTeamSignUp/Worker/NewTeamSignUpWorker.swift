//
//  NewTeamSignUpWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 04/11/23.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

protocol NewTeamSignUpWorkerProtocol {
    func createNewGameOnFirebase(
        model: NewTeamSignUpModel,
        completion: @escaping((String?)->Void))
}

final class NewTeamSignUpWorker: NewTeamSignUpWorkerProtocol {
    
    private let firestoreReference = Firestore.firestore()
    
    func createNewGameOnFirebase(
        model: NewTeamSignUpModel,
        completion: @escaping((String?)->Void)){
            let id = generateRandomID()
            
            firestoreReference.document("team/\(id)").setData([
                "name" : model.name,
                "color" : model.color.accessibilityName,
                "sumPointTeam" : model.sumPointTeam,
                "minPoinTeam" : model.minPoinTeam,
                "sumPointGoal" : model.sumPointGoal,
                "id": id
            ]) { error in
                if let error {
                    completion(nil)
                } else {
                    completion(id)
                }
            }
            
            uploadImage(
                image: model.profileImage,
                id: id)
        }
    
    //MARK: Private methods
    private func uploadImage(image: UIImage, id: String){
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let imageRef = storageReference.child("profile/\(id)).jpg")
        
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            imageRef.putData(imageData, metadata: nil) { [weak self] (metadata, error) in
                guard error == nil else { return }
                
                imageRef.downloadURL { (url, error) in
                    if let downloadURL = url {
                        self?.firestoreReference.document(
                            "team/\(id)").updateData(["image": downloadURL.absoluteString])
                    }
                }
                
            }
        }
    }
    
    private func generateRandomID() -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomID = ""

        for _ in 0..<6 {
            let randomIndex = Int(arc4random_uniform(UInt32(characters.count)))
            let randomCharacter = characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
            randomID.append(randomCharacter)
        }

        return randomID
    }
    
}
