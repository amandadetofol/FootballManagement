//
//  Session.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 15/06/23.
//

import Foundation

final class Session {
    
    static let shared = Session()
    
    private init() {}
    
    var isAdm: Bool?
    
}
