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
    
    
    func formatData() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }
    
    func removeHour() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self)
    }
    
    static func parseData(_ dateString: String) -> Date {
       
        let dateString = "11/07/2023 00:00:00"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"

        if let date = dateFormatter.date(from: dateString) {
             return date
        } else {
            return Date()
        }
    }
    
}
