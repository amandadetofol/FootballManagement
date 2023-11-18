//
//  PersonalInformationsWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

protocol PersonalInformationsWorkerProtocol {
    func getPersonalInformations(
        _ completion: @escaping ((PersonalInformationsViewModel?) -> Void),
        email: String?)
    func updatePersonalInformations(
        personalInformations: PersonalInformationsViewModel,
        changeImage: Bool,
        completion: @escaping((Bool)->Void),
        email: String?)
    func deleteUser(
        email: String,
        completion: @escaping((Bool)->Void))
}

final class PersonalInformationsWorker: PersonalInformationsWorkerProtocol {
    
    private let firebaseAuthProvider = Auth.auth()
    private let firestoreProvider = Firestore.firestore()
    
    func getPersonalInformations(_ completion: @escaping ((PersonalInformationsViewModel?) -> Void),
                                 email: String?) {
        firestoreProvider.document("\(Session.shared.teamId ?? "")/\(email ?? Session.shared.loggedUserEmail ?? "")").getDocument { [weak self] document, error in
            guard error == nil,
                  let self = self else {
                completion(nil)
                return
            }
            
            completion(
                PersonalInformationsViewModel(
                    name: document?["name"] as? String ?? "",
                    email: document?["email"] as? String,
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
        completion: @escaping((Bool)->Void),
        email: String?) {
            firestoreProvider.document("\(Session.shared.teamId ?? "")/\(email ?? Session.shared.loggedUserEmail ?? "")").updateData([
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
    
    func deleteUser(
        email: String,
        completion: @escaping((Bool)->Void)){
            Auth.auth().currentUser?.delete { [weak self] error in
                guard error == nil,
                      let self else {
                    completion(false)
                    return
                }
                
                self.firestoreProvider.collection(Session.shared.teamId ?? "").document(email).getDocument { document, error in
                    guard error == nil,
                          let document,
                          let currentposition = document["rankingPlace"] as? Float else {
                        completion(false)
                        return
                    }
                    
                    self.firestoreProvider.collection(Session.shared.teamId ?? "").document(email).delete { error in
                        guard error == nil else {
                            completion(false)
                            return
                        }
                        
                        self.firestoreProvider.document("sort/list").getDocument {  document, error in
                            guard error == nil,
                                  let document = document else {
                                completion(false)
                                return
                            }
                            
                            guard let listOfSorts = document["list"] as? [String],
                                  let activeSort = listOfSorts.last else {
                                completion(false)
                                return
                            }
                            
                            
                            let reference = self.firestoreProvider.document("sort/\(activeSort)/whiteteam/\(email)")
                            reference.delete { error in
                                print(error)
                            }
                            
                            
                            let reference1 = self.firestoreProvider.document("sort/\(activeSort)/blackteam/\(email)")
                            reference1.delete { error in
                                print(error)
                            }
                            
                        }
                        
                        self.firestoreProvider.collection(Session.shared.teamId ?? "").getDocuments { querySnapshot, error in
                            guard error == nil,
                                  let querySnapshot else {
                                completion(false)
                                return
                            }
                            
                            querySnapshot.documents.forEach({ document in
                                guard let email = document["email"] as? String,
                                      let position = document["rankingPlace"] as? Float else { return }
                                
                                if position > currentposition {
                                    self.firestoreProvider.document("\(Session.shared.teamId ?? "")/\(email)").updateData(["rankingPlace" : position-1])
                                }
                                    
                            })
                            completion(true)
                        }
                    }
                }
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
                            "\(Session.shared.teamId ?? "")/\(Session.shared.loggedUserEmail ?? "")").updateData(["image": downloadURL.absoluteString])
                    }
                }
                
            }
        }
    }
    
}
