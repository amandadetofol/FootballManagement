//
//  Date.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 27/06/23.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
}
