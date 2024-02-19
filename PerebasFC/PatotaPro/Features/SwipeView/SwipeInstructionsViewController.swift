//
//  SwipeInstructionsViewController.swift
//  PatotaPro
//
//  Created by Amanda Detofol on 19/02/24.
//

import UIKit

final class SwipeInstructionsViewController: UIViewController {
    
    lazy var swipeInstructionsView: SwipeInstructionView = {
        let view = SwipeInstructionView()
        view.frame =  CGRect(x: 0, y: 0, width: 100, height: 200)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view = swipeInstructionsView
        self.definesPresentationContext = true
    }
    
}
