//
//  Session.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 15/06/23.
//

import UIKit

final class Session {
    
    static let shared = Session()
    
    private init() {}
    
    var isAdm: Bool?
    var user: User?
    var loggedUserEmail: String?
    var teamId: String?
    var highLightColor = UIColor.systemBlue.withAlphaComponent(0.5)
}
