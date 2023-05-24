//
//  HomeViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 24/05/23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private lazy var homeView: HomeView = {
        let homeView = HomeView()
        
        return homeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true 
        self.view = homeView
    }
    
}


