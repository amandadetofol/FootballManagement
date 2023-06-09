//
//  ChatMessageListView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 09/06/23.
//

import UIKit

protocol ChatMessageListViewDelegate: AnyObject {
    func sendMessage(message: String)
}

final class ChatMessageListView: UIView {
    
    weak var delegate: ChatMessageListViewDelegate?
     
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.isAccessibilityElement = false
        scrollView.isScrollEnabled = true 
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isAccessibilityElement = false
        
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .bottom
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 0, bottom: -32, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.isUserInteractionEnabled = true
        
        return stackView
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.withAlphaComponent(0.50).cgColor
        textView.delegate = self
        
        return textView
    }()
    
    init(){
        super.init(frame: .zero)
        setupView()
        setupConstraints()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private func setupView(){
        addSubview(scrollView)
        addSubview(textView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: -16),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            textView.heightAnchor.constraint(equalToConstant: 108),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            self.textView.frame.origin.y = keyboardFrame.height + 72
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        self.textView.frame.origin.y = UIScreen.main.bounds.height - 108
    }
    
    private func sendMessage(){
        let newMessage = ChatMessageView(with: Chat(
            messageId: "01",
            sender: UserChat(
                id: String(),
                fullName: String()),
            text: textView.text,
            timestamp: Date(),
            myId: "01"))
        contentStackView.addArrangedSubview(newMessage)
        delegate?.sendMessage(message: textView.text)
    }

}

extension ChatMessageListView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            textView.frame.origin.y = UIScreen.main.bounds.height - 108
            sendMessage()
            textView.text = ""
            return false
        }
        return true
    }
    
}
