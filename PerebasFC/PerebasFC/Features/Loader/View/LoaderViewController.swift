//
//  LoaderViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 27/07/23.
//

import UIKit

final class LoaderViewController: UIViewController {
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.color = .gray
        
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        view = activityIndicatorView
        activityIndicatorView.startAnimating()
    }

}
