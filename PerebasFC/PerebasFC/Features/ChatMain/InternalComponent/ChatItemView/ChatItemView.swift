
import UIKit

protocol ChatItemViewDelegate: AnyObject {
    func handleChatItemViewTap(model: ChatItemViewModel)
}

final class ChatItemView: UIControl {
    
    var model: ChatItemViewModel?
    weak var delegate: ChatItemViewDelegate?
    
    private lazy var initialsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .black
        label.layer.cornerRadius = 16
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.clipsToBounds = true
        
        return label
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        return label
    }()
    
    private lazy var lastMessageDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16.0)
        
        return label
    }()
    
    private lazy var arrowIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.forward"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = .black
        
        return imageView
    }()
    
    private lazy var newMessagesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .systemRed
        label.layer.cornerRadius = 12
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.clipsToBounds = true
        
        return label
    }()
    
    init(with model: ChatItemViewModel){
        super.init(frame: .zero)
        initialsLabel.text = model.initials
        fullNameLabel.text = model.fullName
        lastMessageDescriptionLabel.text = model.lastMessagePartialDescription
        
        if model.shouldShowNotificationsLabel {
            newMessagesLabel.isHidden = false
            newMessagesLabel.text = String(model.numberOfNotifications)
        }
        self.model = model
        setupView()
        setupConstraints()
        setupBorders()
        backgroundColor = .white
        updateAccessibility(model: model)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubviews([
            initialsLabel,
            fullNameLabel,
            lastMessageDescriptionLabel,
            arrowIconImageView,
            newMessagesLabel])
        addTarget(self, action: #selector(handleChatItemViewTap), for: .touchUpInside)
    }
    
    private func updateAccessibility(model: ChatItemViewModel){
        self.isAccessibilityElement = true
        self.accessibilityTraits = .button
        self.accessibilityLabel = "\(model.numberOfNotifications) mensagem de: \(model.fullName). Conteúdo: \(model.lastMessagePartialDescription). Ir para conversa."
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 76),
            
            initialsLabel.heightAnchor.constraint(equalToConstant: 32),
            initialsLabel.widthAnchor.constraint(equalToConstant: 32),
            initialsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            initialsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            fullNameLabel.leadingAnchor.constraint(equalTo: initialsLabel.trailingAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: arrowIconImageView.leadingAnchor, constant: -16),
            
            lastMessageDescriptionLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 4),
            lastMessageDescriptionLabel.leadingAnchor.constraint(equalTo: initialsLabel.trailingAnchor, constant: 16),
            lastMessageDescriptionLabel.trailingAnchor.constraint(equalTo: arrowIconImageView.leadingAnchor, constant: -16),
            
            arrowIconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            arrowIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            arrowIconImageView.heightAnchor.constraint(equalToConstant: 16),
            arrowIconImageView.widthAnchor.constraint(equalToConstant: 16),
            
            newMessagesLabel.heightAnchor.constraint(equalToConstant: 24),
            newMessagesLabel.widthAnchor.constraint(equalToConstant: 24),
            newMessagesLabel.topAnchor.constraint(equalTo: topAnchor, constant: -16),
            newMessagesLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setupBorders(){
        layer.cornerRadius = 10
        layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 1
    }
}

extension ChatItemView {
    
    @objc func handleChatItemViewTap(){
        guard let model = model else { return }
        delegate?.handleChatItemViewTap(model: model)
    }
    
}
