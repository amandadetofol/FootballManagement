//
//  HomeViewModel.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 23/05/23.
//

import UIKit

struct HomeViewModel {
    let header: HomeHeaderViewModel
    let menuCards: [MenuCard]
    let warning: [UserAlertWarningViewModel]
}

struct MenuCard {
    let title: String
    let subtitle: String
    let subAreaActionKey: InternalLinkRedirectKeys
    let icon: UIImage
}


