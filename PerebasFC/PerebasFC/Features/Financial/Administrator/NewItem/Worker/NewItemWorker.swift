//
//  NewItemWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 17/08/23.
//

import Foundation

protocol NewItemWorkerProtocol {
    func createNewItem(
        newItem: NewItemModel,
        completion: @escaping((Bool)->Void))
}

final class NewItemWorker: NewItemWorkerProtocol {
    
    func createNewItem(
        newItem: NewItemModel,
        completion: @escaping ((Bool) -> Void)) {
            completion(true)
        }
    
}
