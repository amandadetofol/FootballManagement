//
//  AdministratorPendenciesDetailsCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 19/08/23.
//

import UIKit

protocol AdministratorPendenciesDetailsCoordinatorProtocol {
    func openUrl(url: String?)
}

final class AdministratorPendenciesDetailsCoordinator: AdministratorPendenciesDetailsCoordinatorProtocol {
    
    func openUrl(url: String?) {
        guard let url = url,
              let urlString = URL(string: url) else { return }
        UIApplication.shared.openURL(urlString)
    }
    
}
