//
//  ChatMessageView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 09/06/23.
//

import UIKit

final class ChatMessageView: UIView {
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        
        return stackView
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.layer.cornerRadius = 10
        label.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        label.layer.borderWidth = 1
        
        return label
    }()
    
    private lazy var checkMarkImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "checkmark"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    init(with model: Chat){
        super.init(frame: .zero)
        messageLabel.text = model.text
        messageLabel.backgroundColor = model.isMyMessage ? .white : .systemYellow.withAlphaComponent(0.20)
        checkMarkImageView.tintColor = model.wasRead ? .systemGreen : .systemBlue
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(contentStackView)
        contentStackView.addArrangedSubviews([
            messageLabel,
            checkMarkImageView])
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}
