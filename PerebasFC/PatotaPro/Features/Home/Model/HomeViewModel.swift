//
//  HomeViewModel.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 23/05/23.
//

import UIKit

struct HomeViewModel {
    let isAdm: Bool
    let header: HomeHeaderViewModel
    let menuCards: [MenuItemViewModel]?
}

struct HomeTeamInfo {
    let shirtNumber: String
    let teamName: String
    let position: String 
}
