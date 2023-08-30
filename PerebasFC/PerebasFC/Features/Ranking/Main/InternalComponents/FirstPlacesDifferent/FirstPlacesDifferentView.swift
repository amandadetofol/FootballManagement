//
//  FirstPlacesDifferentView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 01/06/23.
//

import UIKit

final class FirstPlacesDifferentView: UIView {
    
    private lazy var firstPlaceBarView: BarAndThrophyView = {
        let view = BarAndThrophyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var secondPlaceBarView: BarAndThrophyView = {
        let view = BarAndThrophyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var thirdPlaceBarView: BarAndThrophyView = {
        let view = BarAndThrophyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    init(){
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(
        firstPlaceModel: BarAndTrophyViewModel,
        secondPlaceModel: BarAndTrophyViewModel,
        thirdPlaceModel: BarAndTrophyViewModel){
            firstPlaceBarView.setupView(with: firstPlaceModel)
            secondPlaceBarView.setupView(with: secondPlaceModel)
            thirdPlaceBarView.setupView(with: thirdPlaceModel)
            updateAccessibility(
                firstPlaceModel: firstPlaceModel,
                secondPlaceModel: secondPlaceModel,
                thirdPlaceModel: thirdPlaceModel)
        }
    
    private func updateAccessibility(
        firstPlaceModel: BarAndTrophyViewModel,
        secondPlaceModel: BarAndTrophyViewModel,
        thirdPlaceModel: BarAndTrophyViewModel){
            firstPlaceBarView.updateAccessibility(with: firstPlaceModel)
            secondPlaceBarView.updateAccessibility(with: secondPlaceModel)
            thirdPlaceBarView.updateAccessibility(with: thirdPlaceModel)
        }
    
    private func setupView(){
        addSubviews([
            firstPlaceBarView,
            secondPlaceBarView,
            thirdPlaceBarView])
        self.backgroundColor = .white
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 148),
            
            firstPlaceBarView.bottomAnchor.constraint(equalTo: bottomAnchor),
            firstPlaceBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            secondPlaceBarView.bottomAnchor.constraint(equalTo: bottomAnchor),
            secondPlaceBarView.leadingAnchor.constraint(equalTo: firstPlaceBarView.trailingAnchor, constant: 50),
            
            thirdPlaceBarView.bottomAnchor.constraint(equalTo: bottomAnchor),
            thirdPlaceBarView.leadingAnchor.constraint(equalTo: secondPlaceBarView.trailingAnchor, constant: 50),
       ])
    }
    
}
