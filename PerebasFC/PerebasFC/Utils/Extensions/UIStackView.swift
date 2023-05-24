//
//  UIStackView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 23/05/23.
//

import Foundation

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: [UIView]){
        views.forEach { subview in
            self.addArrangedSubview(subview)
        }
    }
    
}
