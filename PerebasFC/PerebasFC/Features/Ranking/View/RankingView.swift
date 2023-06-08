//
//  RankingView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 01/06/23.
//

import UIKit

final class RankingView: UIView {
    
    private lazy var firstPlacesView: FirstPlacesDifferentView = {
        let firstPlacesView = FirstPlacesDifferentView()
        firstPlacesView.translatesAutoresizingMaskIntoConstraints = false
        
        return firstPlacesView
    }()
    
    private lazy var awardsView: FirstPlacesGiftsView = {
        let view = FirstPlacesGiftsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 32, left: 32, bottom: -32, right: -32)
        stackView.isUserInteractionEnabled = true
        
        return stackView
    }()
    
    init(){
        super.init(frame: .zero)
        setupView()
        setupConstraints()
        backgroundColor = .white
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(with model: RankingViewModel){
        self.firstPlacesView.updateView(
            firstPlaceModel: model.firstPlaceModel,
            secondPlaceModel: model.secondPlaceModel,
            thirdPlaceModel: model.thirdPlaceModel)
        self.awardsView.updateView(with: model.awards)
        
        model.otherParticipants.forEach { participantViewModel in
            let card = CommonnPlacesView()
            card.updateView(with: participantViewModel)
            card.translatesAutoresizingMaskIntoConstraints = false
            self.stackView.addArrangedSubview(card)
            card.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
            card.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        }
    }
    
    private func setupView(){
        addSubviews([firstPlacesView, awardsView, scrollView])
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            firstPlacesView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            firstPlacesView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            
            awardsView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            awardsView.leadingAnchor.constraint(equalTo: firstPlacesView.leadingAnchor, constant: 178),
            
            scrollView.topAnchor.constraint(equalTo: firstPlacesView.bottomAnchor, constant: 32),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
        ])
    }
    
}