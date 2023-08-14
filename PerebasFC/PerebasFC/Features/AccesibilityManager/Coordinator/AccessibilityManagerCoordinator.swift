//
//  AccessibilityManagerCoordinator.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 13/08/23.
//

import UIKit

protocol AccessibilityManagerCoordinatorProtocol {
    func handleButtonTap()
}

final class AccessibilityManagerCoordinator: AccessibilityManagerCoordinatorProtocol {
    
    func handleButtonTap() {
        if let settings = URL(string: "App-prefs:root=General&path=ACCESSIBILITY/"),
           UIApplication.shared.canOpenURL(settings) {
            UIApplication.shared.open(
                settings,
                options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly : false]) { _ in
                }
        }
    }
    
}
