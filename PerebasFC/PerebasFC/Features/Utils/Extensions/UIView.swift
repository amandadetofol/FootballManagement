//
//  UIView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 16/05/23.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]){
        views.forEach { subview in
            self.addSubview(subview)
        }
    }
    
}
