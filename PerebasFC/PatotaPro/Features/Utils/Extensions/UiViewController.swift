//
//  UiViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 21/09/23.
//

import UIKit

extension UIViewController {
    
    func handleKeyBoardRemoveWhenClickOutsideField(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapScreen(){
        view.endEditing(true)
    }
    
}
