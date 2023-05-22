//
//  HomeView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 22/05/23.
//

import UIKit

final class HomeView: UIView {
    
    private lazy var headerView: HomeHeaderView = {
        let headerView = HomeHeaderView()
        
        return headerView
    }()
    
    init(){
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
