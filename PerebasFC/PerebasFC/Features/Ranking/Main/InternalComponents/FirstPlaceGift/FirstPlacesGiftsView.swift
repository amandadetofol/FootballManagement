//
//  FirstPlacesGiftsView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 01/06/23.
//

import UIKit

protocol FirstPlacesGiftsViewDelegate: AnyObject {
    func handleEditAwardsButtonTap()
}

final class FirstPlacesGiftsView: UIView {
    
    weak var delegate: FirstPlacesGiftsViewDelegate?
    
    private lazy var awardLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "Prêmios"
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        return label
    }()
    
    private lazy var editAwardsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.isHidden = true
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(handlEditAwardsButtontTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var firstAwardLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16.0)
        
        return label
    }()
    
    private lazy var secondAwardLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16.0)
        
        return label
    }()
    
    private lazy var thirdAwardLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16.0)
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: -4, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        
        return stackView
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
    
    func updateView(with model: FirstPlaceGiftsViewModel){
        firstAwardLabel.text = model.first
        secondAwardLabel.text = model.second
        thirdAwardLabel.text = model.third
        editAwardsButton.isHidden = !model.isAdm
    }
    
    private func setupView(){
        addSubview(stackView)
        stackView.addArrangedSubviews([
            editAwardsButton,
            awardLabel,
            firstAwardLabel,
            secondAwardLabel,
            thirdAwardLabel])
        backgroundColor = .white
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}

extension FirstPlacesGiftsView {
    
    @objc func handlEditAwardsButtontTap(){
        delegate?.handleEditAwardsButtonTap()
    }
    
}
