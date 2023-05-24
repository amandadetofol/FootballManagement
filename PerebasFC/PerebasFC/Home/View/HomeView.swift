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
    
    private lazy var menuStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemRed.withAlphaComponent(0.5)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        return stackView
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
