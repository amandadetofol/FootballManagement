//
//  LoaderCoodinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 27/07/23.
//

import UIKit

protocol LoaderCoodinatorProtocol {
    func showLoader()
    func removeLoader()
}

final class LoaderCoodinator: LoaderCoodinatorProtocol {
    
    private let navigationController: UINavigationController
    private let loader = LoaderViewController()
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func showLoader(){
        loader.modalPresentationStyle = .overFullScreen
        navigationController.present(loader, animated: false)
    }
    
    func removeLoader(){
        loader.dismiss(animated: true)
    }
    
}
