//
//  LoaderCoodinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 27/07/23.
//

import UIKit

protocol LoaderCoodinatorProtocol {
    func showLoader(_ completion: @escaping(()->Void))
    func removeLoader(_ completion: @escaping(()->Void))
}

final class LoaderCoodinator: LoaderCoodinatorProtocol {
    
    private let navigationController: UINavigationController
    private let loader = LoaderViewController()
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func showLoader(_ completion: @escaping(()->Void)){
        loader.modalPresentationStyle = .overFullScreen
        navigationController.present(
            loader,
            animated: false,
            completion: completion)
    }
    
    func removeLoader(_ completion: @escaping(()->Void)){
        loader.dismiss(
            animated: true,
            completion: completion)
    }
    
}
