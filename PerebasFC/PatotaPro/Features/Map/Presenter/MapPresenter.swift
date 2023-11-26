//
//  MapPresente.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 23/08/23.
//

import Foundation
import FirebaseFirestore

protocol MapPresenterProtocol {
    func updateView(with url: DocumentSnapshot?)
}

protocol MapViewProtocol: AnyObject {
    func updateView(with url: String)
}

final class MapPresenter: MapPresenterProtocol {
    
    weak var view: MapViewProtocol?
    
    func updateView(with url: DocumentSnapshot?){
        view?.updateView(with: parseDocumentSnapShotToString(documentSnapShot: url))
    }
    
    //MARK: Private method
    private func parseDocumentSnapShotToString(documentSnapShot: DocumentSnapshot?) -> String {
        return documentSnapShot?["local"] as? String ?? ""
    }
}
